import operator
import random
from printHandler import *
from . import id_handler
from . import loot_handler
from asc_fnc.asc_db.database import asc_db
from asc_fnc import asc_g_msg
import copy

# Default Variables: (DEV/WIP? Put it somewhere else, idk yet)
DEFAULT_loot_count = 2
DEFAULT_loot_skill_multiplier = 2


########################################################################
# INV INV INV INV INV INV INV INV INV INV INV INV INV INV INV INV INV #
######################################################################


def inv_crate_create(sData, clientID: str = None, pos: list = None, crateID: str = "", lootType: str = None, isLootcrate: int = 0, persistent: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 20, inv_cols: int = 8, model: str = "IG_supplyCrate_F"):
    """
    :param sData:       ServerData (auto-passed)
    :param clientID:    A3 playerUID
    :param pos:         list - [[x,y,z],dir]
    :param crateID:     "ID of the"
    :param lootType:    String - type of loot, passed by the gameserver
    :param isLootcrate: is the crate a newly created Loot-crate or not
    :param loot_count:  Int - amount of Items to add (can be altered by Loot-skill of the player)
    :param inv_rows:    Int - Rows
    :param inv_cols:    Int - Columns
    The following arguments are ONLY for creating persistent crates:
    :param persistent:  Save to Database or not (persistent crates only)
    :param model:       A3 typeOf Class (persistent crates only)
    :return:
    """

    if None in [clientID, pos]:
        PRINT_WARNING(f"INV_HANDLER: inv_crate_create: clientID or Pos not transmitted: clientID: {clientID} | pos: {pos}")
        return

    if persistent > 0:
        # only persistent Crates store the model
        model = model
    else:
        model = ""

    if isLootcrate == 0:
        # Player created Crates (e.g: Opening Inventory to drop things)
        inv_rows = 20
        inv_cols = 8

    invData = inv_data_create(crateID=crateID, model=model, pos=pos, lootType=lootType, inv_rows=inv_rows, inv_cols=inv_cols)

    # store the Inventory
    if persistent > 0:
        # Add to the "crates" (permanent) Database. Since it is no lootcrate, don't fill it.
        sData.database.crates[crateID] = invData
        asc_db.db_save(sData.database)
    else:
        # Check if loot needs to be created for this crate:
        if isLootcrate > 0:
            playerData = sData.database.players[clientID]
            # ToDo: Do a recheck, when the Skill-system is properly added
            # Get the scavenging Skill from the requesting player:
            if "scavenging" in playerData["skills"]:
                skill_scavenging = sData.database.players[clientID]["skills"]["scavenging"]
            else:
                skill_scavenging = 0
            # PRINT_DEBUG(f"INV_HANDLER: inv_crate_create: skill_scavenging: {skill_scavenging}")
            # Fill the crate (also updates invData):
            inv_crate_loot_fill(sData=sData, invData=invData, lootType=lootType, loot_count=loot_count, crateID=crateID, skill_scavenging=skill_scavenging)
            PRINT_DEBUG(f"INV_HANDLER: inv_crate_create: invData: {invData}")

        # Add to the "sessionCrates" Database. They won't be saved into the database files.
        sData.database.sessionCrates[crateID] = invData

    # Get the connection of the requesting client
    conClient = sData.user_active[clientID]["con"]
    # send the invData to the Client
    # inv_data_send_toClient(invData, conClient)
    return invData


def inv_crate_loot_fill(sData, invData: dict = None, lootType: str = None, loot_count: int = DEFAULT_loot_count, crateID: str = "", skill_scavenging: int = 0):
    """Fill the given invData with loot items? Yeah, i guess that's what this one does.

    :param sData:
    :param invData:
    :param lootType:
    :param loot_count:
    :param crateID:
    :param skill_scavenging:
    :return:
    """
    if not invData:
        PRINT_WARNING(f"inv_crate_loot_fill: INVDATA WAS NOT PASSED/CREATED EARLIER!")
        return
    # ToDo: recalculate the loot_count properly, based on the scavenging skill! (chance-based?)
    # check if skill is high enough, otherwise randRange will complain, that the "end"-number isn't high enough... (must be "start < end")
    if skill_scavenging > 0:
        loot_count = random.randrange(loot_count, int(loot_count + (skill_scavenging * DEFAULT_loot_skill_multiplier)))
    # PRINT_DEBUG(f"INV_HANDLER: inv_crate_create: loot_count: {loot_count}")

    # get the list of Item names
    items_list = loot_handler.loot_item_list_create(sData=sData, loot_count=loot_count, loot_type=lootType)
    # PRINT_DEBUG(f"INV_HANDLER: inv_crate_create: items_list_raw: {items_list}\n----------------")

    # cycle through all the itemsSubTypes
    for itemName in items_list:
        item = item_create(sData=sData, itemSubTypeName=itemName)
        # ToDo: update/calc stats, depending on... something... skill? Random? idk
        PRINT_DEBUG(f"inv_crate_loot_fill: Item: {item}")
        # Add Item to Inventory
        inv_item_new_add(sData=sData, invData=invData, item=item, invSubID="1000", crateID=crateID)


def inv_item_new_add(sData, invData, item: dict = None, invSubID: str = "1000", crateID: str = ""):
    """

    :param sData:
    :param invData:
    :param item:
    :param invSubID:
    :param crateID:
    :return:
    """
    if not item:
        PRINT_WARNING(f"inv_item_new_add - Item not passed! item: {item}")
        return

    isFlipped = 0
    parentData = item_baseData_get(sData=sData, subTypeName=item["subType"])
    # PRINT_ATTENTION(f"inv_item_new_add - parentData: {parentData}")
    # get the usedSlots
    usedSlots_cur = inv_slots_used_get(invData=invData["inventory"], invSubID=invSubID)

    # get Inventory sizes and make it an [row,col]-list
    invSize = [invData["inventory"][invSubID]["inv_rows"], invData["inventory"][invSubID]["inv_cols"]]
    # PRINT_ATTENTION(f'inv_item_new_add - parentData["baseData"]: {parentData["baseData"]}')

    # "Find free slot"
    invPos = item_slots_free_find(invDataSize=invSize, itemSize=parentData["baseData"]["size"], slotsUsed=usedSlots_cur, slotsIgnore=[], isFlipped=isFlipped)
    if not invPos:
        PRINT_WARNING(f"inv_item_new_add - Item could not be added: No free slot found! Item: {item}")
        return
    # check the new Inv, if there are enough slots free and return the newly blocked slots.
    slotsUsed_item = item_slots_used_calc(invDataSize=invSize, itemSize=parentData["baseData"]["size"], slotStart=invPos[0], slotsUsed=usedSlots_cur, slotsIgnore=[], isFlipped=isFlipped)
    if not slotsUsed_item:
        PRINT_WARNING(f"inv_item_new_add: ITEM COULD NOT BE ADDED: Item: {item}")
        return None

    # update the new usedSlots in the Inventory:
    inv_slots_used_add(invData=invData["inventory"], invSubID=invSubID, slotsUsed=slotsUsed_item)

    # Update the invSub Data and curInv data
    item["invSub"] = invSubID
    item["curInv"] = crateID
    item["invPos"] = invPos[0]
    # Add the Item to the "itemData":
    invData["itemData"][item["id"]] = item


def inv_data_create(crateID: str = "", model: str = "", pos: list = None, lootType: str = "", inv_rows: int = 0, inv_cols: int = 0):
    """Create the base data structure for all Inventories

    :param crateID:
    :param model:
    :param pos:
    :param lootType:
    :param inv_rows:
    :param inv_cols:
    :return:
    """
    pos = pos or [[], 0]    # if pos = None (false) -> select the default value

    invData = {
        "crateID":   crateID,
        "model":     model,
        "pos":       pos,
        "type":      lootType,
        'inventory': {
            "1000": {
                "crateID": crateID,
                "inv_rows": inv_rows,
                'inv_cols': inv_cols,
                "invID":    "1000",
                "invArea":  "an_inv_external_area",
                "invGrid":  "an_inv_external_grid",
                "slotsUsed": [],
                "isSlot": 0
                }
            },
        "itemData":  {}
        }
    return invData


def inv_data_request(sData, clientID: str = None, pos: list = None, crateID: str = None, lootType: str = None, isLootcrate: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 16, inv_cols: int = 8, persistent: int = 0, model: str = "IG_supplyCrate_F"):
    """Try to get the Crate data. If not found -> Create a new one. We simply assume the Data, coming from the Game-server, is correct/valid.

    :param sData:
    :param clientID:
    :param pos:
    :param crateID:
    :param lootType:
    :param isLootcrate:
    :param loot_count:
    :param inv_rows:
    :param inv_cols:
    :param persistent:
    :param model:
    :return:
    """

    if crateID in sData.database.crates:
        invData = sData.database.crates[crateID]
    elif crateID in sData.database.sessionCrates:
        invData = sData.database.sessionCrates[crateID]
    else:
        invData = inv_crate_create(sData=sData, clientID=clientID, pos=pos, crateID=crateID, lootType=lootType, isLootcrate=isLootcrate, loot_count=loot_count, inv_rows=inv_rows, inv_cols=inv_cols, persistent=persistent)

    # ToDo: Add an "in use"-check (players, currently having that Inventory open)
    # send Inventory data back to the requesting client
    conClient = sData.user_active[clientID]["con"]
    PRINT_DEBUG(f"INV_HANDLER: inv_data_request: Crate found, sending Data to Client.")

    # send the invData to the Client
    inv_data_send_toClient(invData, conClient)


def inv_data_update_force(client, invID_old: str, invID_new: str):
    """ Trigger an update of the item- and Inventory Data on the Client! In case something went wrong with the dataSync.

    cData       client Data
    invID_old   "" - ID #1
    invID_new:  "" - ID #2
    """

    # Since we want to send over the remote Inventory -> Check if invID_old is NOT the player Inv.
    if invID_old != client.puid:
        # PRINT_ATTENTION(f"inv_data_update_force - PRE inv_data_get: invID_old: {invID_old}")
        inv_remote, isPlayer = inv_data_get(client, invID_old)
    else:
        # PRINT_ATTENTION(f"inv_data_update_force - PRE inv_data_get: invID_new: {invID_new}")
        inv_remote, isPlayer = inv_data_get(client, invID_new)

    # resending it, triggers a force-reopen of the Inventory (instantly)
    if not inv_remote:
        PRINT_WARNING(f"inv_data_update_force: inv_remote not found!")
        return

    dataset = {
        "crateID": client.puid,
        "itemData": client.cData["itemData"],
        "inventory": client.cData["inventory"]
        }
    # update the player Gear
    asc_g_msg.sendMsg("player_gear_set", dataset, client.con_client)
    # Remove the dict entry: "inv_grid" (not needed on the client)
    # send the stripped Remote Inventory back to the player and trigger the Inventory UI to be reopen, so it loads the new data
    inv_data_send_toClient(inv_remote, client.con_client)


def inv_data_send_toClient(invData, conClient):
    PRINT_ATTENTION(f"inv_data_send_toClient: invData: {invData}")
    dataset = {
        "crateID": invData["crateID"],
        "itemData": invData["itemData"],
        "inventory": invData["inventory"]
        }
    asc_g_msg.sendMsg("ret_inv_crateData", dataset, conClient)


def inv_slots_used_get(invData: dict, invSubID: str):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    "1000"
    :return:            [[0, 0], [0, 1], ...]
    """
    return invData[invSubID]["slotsUsed"]

def inv_slots_used_set(invData: dict, invSubID: str, slotsUsed: list):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    "1000"
    :param slotsUsed:   [[0, 0], [0, 1], ...]
    :return:            None
    """
    invData[invSubID]["slotsUsed"] = slotsUsed

def inv_slots_used_add(invData: dict, invSubID: str, slotsUsed: list):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    "1000"
    :param slotsUsed:   [[0, 0], [0, 1], ...]
    :return:            None
    """
    invData[invSubID]["slotsUsed"].extend(slotsUsed)

def inv_slots_used_remove(invData: dict, invSubID: str, slotsUsed: list):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    "1000"
    :param slotsUsed:   [[0, 0], [0, 1], ...]
    :return:            None
    """
    slotsUsed_cur = invData[invSubID]["slotsUsed"]
    for slot in slotsUsed:
        if slot in slotsUsed_cur:
            # print(invData[invSubID]["slotsUsed"])
            slotsUsed_cur.remove(slot)

    return invData[invSubID]["slotsUsed"]


# called by Server only!
def inv_data_remove(sData, crateID: str = ""):
    # Check the Session Crates
    if crateID in sData.database.sessionCrates:
        del sData.database.sessionCrates[crateID]
    # Check the persistent Crates (rly?)
    elif crateID in sData.database.crates:
        del sData.database.crates[crateID]
    else:
        PRINT_WARNING(f'INV_HANDLER: inv_data_remove crateID NOT FOUND - crateID: {crateID}')
    return


def inv_data_get(client, invID: str):
    # PRINT_ATTENTION(f"INV_HANDLER: inv_data_get invID : {invID}")
    try:
        # check if player Inventory (mostly used)
        if invID == client.puid:
            # PRINT_DEBUG(f"inv_data_get: isPlayer: True")
            return [client.cData, True]
        else:
            # Check if temporary/Session Crates (used while looting, so 2nd place)
            if invID in client.sData.database.sessionCrates:
                # PRINT_DEBUG(f"inv_data_get: isPlayer: False")
                return [client.sData.database.sessionCrates[invID], False]
            # Last chance: Check the persistent Inventories (most likely the less used from the 3 options)
            elif invID in client.sData.database.crates:
                # PRINT_DEBUG(f"inv_data_get: isPlayer: False")
                return [client.sData.database.crates[invID], False]
            else:
                PRINT_WARNING(f'INV_HANDLER: inv_data_get invID NOT FOUND #1 - ID: {invID}')
                return [{}, False]
    except KeyError:
        PRINT_WARNING(f'INV_HANDLER: inv_data_get invID NOT FOUND #2 - ID: {invID}')
        return [{}, False]
    except Exception as e:
        PRINT_WARNING(f'INV_HANDLER: inv_data_get - UNKNOWN ERROR - ID: {invID}:\n{e}')
        return [{}, False]


#


##########################################################################
# ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM #
########################################################################


def item_create(sData, itemSubTypeName: str):
    """

    :param sData: server Data
    :param itemSubTypeName: STR - Name of the SubType?
    :return:    {} - Dict with the item data
    """
    # PRINT_DEBUG(f"item_create - Creating: {itemSubTypeName}")

    item = item_data_create(itemSubTypeName)
    parentData = item_baseData_get(sData=sData, subTypeName=item["subType"])

    item["itemData"].update(parentData["itemData"])
    # Example output: {'subType': 'SubTypeClassName', 'curInv': '-1', 'invSub': 0, 'invPos': [0, 0], 'isFlipped': 0, 'itemData': {'condition': 150, 'someStuff': 123}}
    # PRINT_DEBUG(f"item_create - item: {item}")

    return item


def item_subType_list_get(sData, typeData: dict, data: list = None) -> list:
    """ Recursively search the item config, until we reach the SubType, that leads to the mainParent!
    Returning a List/Array with classnames,	starting with the SubType, that has the mainParent defined, the leading to the starting subType

    :param sData: Server Data
    :param typeData:
    :param data:        dict - ! Used ONLY, when searching recursively !
    :return:            []
    """
    if data is None:
        data = []

    subTypeParent = typeData["subParent"]   # Data in: sData.itemSubTypes
    subMainParent = typeData["mainParent"]  # Data in: sData.itemParentData

    if not subTypeParent and not subMainParent:
        print("HUGE WOBBLEWOBBLEWOBBLE!")
        return []

    # subMain is not set, so it links to a subType. Recursive fun begins.
    # If BOTH were set -> Ignore the subType!
    if not subMainParent:
        subData = sData.itemSubTypes[subTypeParent]
        item_subType_list_get(sData=sData, typeData=subData, data=data)
        data.append(subTypeParent)

    return data


def item_baseData_create(sData, subTypeName: str):
    # get subTypeData:
    if subTypeName not in sData.itemSubTypes:
        print(f"SUBTYPE NOT FOUND! - {subTypeName}")
        return {}

    # get the "path" to the "base" config and return it, so we can cycle through it and fetch all the needed data
    data_subType = sData.itemSubTypes[subTypeName]
    parentData = item_subType_list_get(sData=sData, typeData=data_subType)
    parentData.append(subTypeName)

    baseData = {}
    for x in parentData:
        tmp_bData = copy.deepcopy(sData.itemSubTypes[x])
        # if first run -> update with the base values
        if not baseData:
            baseData.update(tmp_bData)
            baseData.update({"parentData": {}, "itemData": {}})

        if "parentData" in tmp_bData:
            baseData["parentData"].update(copy.deepcopy(tmp_bData["parentData"]))

        if "itemData" in tmp_bData:
            baseData["itemData"].update(copy.deepcopy(tmp_bData["itemData"]))

    # Make a "deepcopy" of the data, so the original data won't be overwritten. Despite being costly, but we just execute this at start.
    mainParentData = copy.deepcopy(sData.itemParentData[baseData["mainParent"]])
    baseParentData = copy.deepcopy(sData.itemParentData[mainParentData["baseClass"]])
    baseData["baseData"] = mainParentData

    # ! FAILSAFE ! - Do not let the parentBase overwrite the Slot or class_type!
    baseData["baseData"]["slot"] = baseParentData["slot"]
    baseData["baseData"]["class_type"] = baseParentData["class_type"]
    if "size" not in baseData["baseData"]:
        baseData["baseData"]["size"] = baseParentData["size"]

    return baseData

def item_baseData_get(sData, subTypeName: str):
    """

    :param sData: CLASS - ServerData Class
    :param subTypeName: STR - Name of the SubType?
    :return:    {} - Dict with the baseData
    """
    # get Baseclass Data:
    if subTypeName not in sData.itemClasses:
        print(f"SUBTYPE NOT FOUND! - {subTypeName}")
        return {}

    baseClass_baseData = copy.deepcopy(sData.itemClasses[subTypeName])

    return baseClass_baseData


def item_data_create(parent: str = ""):
    """
    :param parent:      parent name
    :return:            itemData (dict)
    """

    # base item Data - Every Item will have these entries!
    itemBase = {
        "id":          id_handler.create_id(),  # Item ID - Will ALWAYS be generated!
        "subType":      parent,  # Base Item Data, the A3 UI can refer to (stored ItemData)
        "curInv":       "-1",  # ID of Inventory, that the Item is in
        "invSub":       0,  # subInventory (in player Inv only!)
        "invPos":       [0, 0],  # TopLeft Position of the Item in the InventoryGrid
        "isFlipped":    0,  # 0/1 - Check if Item was flipped
        "itemData":     {}  # additional data
        }

    return itemBase


def item_data_flip_canFlip(size):
    if size[0] == size[1]:  # if a square -> No need to be flippable, so "1000"
        return False
    else:
        return True


def item_move(client, args):
    """
    :param client:          client Class
    :param args:          list with following entries:
        :itemID:          erm, the itemID? Like: "123456"?
        :invID_old:       ID of the Inventory, the Item is taken off
        :invSubID_old:    ID of the SubInventory, in the MainInv (e.g.: external (0) - Uniform (1012) - Vest (1013) - Pouch (1014) - Backpack (1015)
        :invID_new:       ID of the Inventory, where the Item is put in to
        :invSubID_new:    ID of the SubInventory, in the MainInv (e.g.: external (0) - Uniform (1012) - Vest (1013) - Pouch (1014) - Backpack (1015)
        :invPos_new:      [0,0]
        :isFlipped:       0/1
    """
    PRINT_ATTENTION(f"item_move: args: {args}")
    itemID, invID_old, invSubID_old, invID_new, invSubID_new, invPos_new, isFlipped = args

    PRINT_DEBUG(f"invID_old: {invID_old}")
    PRINT_DEBUG(f"invID_new: {invID_new}")
    invData_old, isPlayer_old = inv_data_get(client, invID_old)
    invData_new, isPlayer_new = inv_data_get(client, invID_new)
    # PRINT_DEBUG(f"invData_old: {invData_old}")
    # PRINT_DEBUG(f"invData_new: {invData_new}")
    # Check: Both inventories were found
    if not invData_old or not invData_new:
        PRINT_WARNING(f"INV_HANDLER: item_move: INVENTORY NOT FOUND:\ninvData_old: {invData_old}\ninvData_new:{invData_new}")
        return False

    moveWithinInv = isPlayer_old == isPlayer_new
    moveWithinInvSub = False
    if moveWithinInv:
        if invSubID_old == invSubID_new:
            moveWithinInvSub = True
    PRINT_DEBUG(f"item_move: moveWithinInv: {moveWithinInv}")
    # Check: If "player to player" transfer (not implemented - Security Reasons - Maybe overkill? idk.. something for later to check again)
    if isPlayer_old and isPlayer_new and not moveWithinInv:
        PRINT_WARNING(f"INV_HANDLER: item_move: PLAYER TO PLAYER TRANSFER DETECTED:\nold: {invID_old}\nnew:{invID_new}")
        return False

    # Check: Item in old Inventory
    if itemID not in invData_old["itemData"]:
        PRINT_WARNING(f"INV_HANDLER: item_move: ITEM NOT FOUND IN OLD INVENTORY:\nold: {invID_old}\nnew:{invID_new}")
        return False

    #############################################
    # get itemData
    itemData_old = invData_old["itemData"][itemID]
    itemData_isFlipped = itemData_old["isFlipped"]
    parentData = item_baseData_get(sData=client.sData, subTypeName=itemData_old["subType"])

    # get Inventory sizes and make it an [row,col]-list
    invSize_old = [invData_old["inventory"][invSubID_old]["inv_rows"], invData_old["inventory"][invSubID_old]["inv_cols"]]
    invSize_new = [invData_new["inventory"][invSubID_new]["inv_rows"], invData_new["inventory"][invSubID_new]["inv_cols"]]

    #############################################
    # get the usedSlots
    usedSlots_old = inv_slots_used_get(invData=invData_old["inventory"], invSubID=invSubID_old)
    usedSlots_new = inv_slots_used_get(invData=invData_new["inventory"], invSubID=invSubID_new)

    # get the currently used slots:
    invOld_usedSlots = item_slots_used_calc(invDataSize=invSize_old, itemSize=parentData["baseData"]["size"], slotStart=itemData_old["invPos"], slotsUsed=usedSlots_old, slotsIgnore=usedSlots_old, isFlipped=itemData_isFlipped)

    # Check if Client just moves the Item around, inside the own Inventory
    if moveWithinInv and moveWithinInvSub:
        slotsIgnore = invOld_usedSlots
    else:
        slotsIgnore = []
    # check the new Inv, if there are enough slots free and return the newly blocked slots.
    invNew_usedSlots = item_slots_used_calc(invDataSize=invSize_new, itemSize=parentData["baseData"]["size"], slotStart=invPos_new, slotsUsed=usedSlots_new, slotsIgnore=slotsIgnore, isFlipped=isFlipped)

    #############################################
    # I guess all checks are done. Let's move it.
    # Remove from old usedSlots
    inv_slots_used_remove(invData=invData_old["inventory"], invSubID=invSubID_old, slotsUsed=invOld_usedSlots)
    # update the new usedSlots
    inv_slots_used_add(invData=invData_new["inventory"], invSubID=invSubID_new, slotsUsed=invNew_usedSlots)

    #############################################
    # delete the Item from the old Inventory...
    del invData_old["itemData"][itemID]

    # ... update the item ...
    itemData_old["invSub"] = invSubID_new
    itemData_old["invPos"] = invPos_new
    itemData_old["isFlipped"] = isFlipped
    itemData_old["curInv"] = invID_new
    # ... and add it to the new one
    invData_new["itemData"][itemData_old["id"]] = itemData_old

    # PRINT_ATTENTION(f'item_move: invData_old["itemData"]: {invData_old["itemData"]}')
    # PRINT_ATTENTION(f'item_move: invData_new["itemData"]: {invData_new["itemData"]}')
    PRINT_OK(f'PlayerInv: {inv_data_get(client, invID_old)[0]}')

    # We are done with the movement. Now check if it was an (un)equip
    # Check if the Item was equipped or not
    listGear = []

    isUnEquip = invData_old["inventory"][invSubID_old]["isSlot"]
    PRINT_DEBUG(f"isUnEquip: {isUnEquip}")
    isEquip = invData_new["inventory"][invSubID_new]["isSlot"]
    PRINT_DEBUG(f"isEquip: {isEquip}")
    if isUnEquip > 0 or isEquip > 0:
        if isUnEquip:
            listGear.append([invSubID_old, ""])
        if isEquip:
            parentData = item_baseData_get(sData=client.sData, subTypeName=invData_new["itemData"][itemData_old["id"]]["subType"])
            className = parentData["baseData"]["class_name"]
            listGear.append([invSubID_new, className])

    # submit: loadout
    dataset = {
        "data_puid": client.puid,
        "data_gear": listGear
        }
    asc_g_msg.sendMsg("player_loadout_set", dataset, client.sData.con_gameServer)

    # ToDo: TEMP! Saving will be done by an extra Thread from the Server!
    client.sData.database.db_save()


def item_slots_used_calc(invDataSize: list, itemSize: list, slotStart: list, slotsUsed: list, slotsIgnore: list, isFlipped: int):
    """ Calculate the used slots in the Inventory, and check if all Slots are free, the by taking the given offset into account.

    :param invDataSize:     [16, 8]
    :param itemSize:        [4, 4]
    :param slotStart:       [0, 0]
    :param slotsUsed:       [[0, 0], [0, 1], ...]
    :param slotsIgnore:     [[0, 0], [0, 1], ...]
    :param isFlipped:       0/1
    :return:                [[0, 0], [0, 1], ...] OR [] (nothing found)
    """
    if slotsIgnore is None:
        slotsIgnore = []

    invRows, invCols = invDataSize
    slotStartRow, slotStartCol = slotStart

    # check if Item is flipped (not implemented yet)
    if isFlipped == 0:
        itemRows, itemCols = itemSize
    else:
        # in case the item was flipped 90° -> Col=Row, Row=Col
        itemCols, itemRows = itemSize

    # Set the offset, to check only
    offset_row = slotStartRow + itemRows
    offset_col = slotStartCol + itemCols

    ret = []
    if offset_row > invRows or offset_col > invCols:
        # PRINT_DEBUG(f"INV_HANDLER: item_slots_used_calc: ITEM EXCEEDS INVENTORY GRIDSPACE!")
        return ret

    for row in range(slotStartRow, offset_row):
        for col in range(slotStartCol, offset_col):
            invSlot = [row, col]
            if invSlot in slotsUsed and invSlot not in slotsIgnore:
                # PRINT_DEBUG(f"INV_HANDLER: item_slots_used_calc: SLOT IS BLOCKED!")   # Debug
                return []
            ret.append(invSlot)
    return ret


def item_slots_free_find(invDataSize: list, itemSize: list, slotsUsed: list, slotsIgnore: list = None, isFlipped: int = 0):
    """ Auto-find free slots for the given Item. Return the slots as list.

    If no Slots were found, return an empty list.

    :param invDataSize:     [16, 8]
    :param itemSize:        [4, 4]
    :param slotsUsed:       [[0, 0], [0, 1], ...]
    :param slotsIgnore:     [[0, 0], [0, 1], ...]
    :param isFlipped:       0/1
    :return:                [[0, 0], [0, 1], ...] OR [] (nothing found)
    """

    invRows, invCols = invDataSize
    # in case the item was flipped 90° -> Col=Row, Row=Col
    if isFlipped > 0:
        itemSize = [itemSize[1], itemSize[0]]

    ret = []
    checkDone = False
    for row in range(invRows):
        for col in range(invCols):
            invSlot = [row, col]
            ret = item_slots_used_calc(invDataSize=invDataSize, itemSize=itemSize, slotStart=invSlot, slotsUsed=slotsUsed, slotsIgnore=slotsIgnore, isFlipped=isFlipped)
            # if free slot found (filled list) -> exit for-loop
            if len(ret) > 0:
                checkDone = True
                break
        if checkDone:
            # print(f"free slots found - {ret}")
            break
    PRINT_OK(f"item_slots_free_find - ret: {ret}")
    return ret





