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


def inv_grid_create(rows, cols):
    ret = []
    for x in range(rows):
        _line = [0] * cols
        ret.append(_line)
    return ret


# try to get the Crate data. If not found -> Create a new one. We simply assume the Data, coming from the Game-server, is correct/valid.
def inv_data_request(sData, clientID: str = None, pos: list = None, crateID: str = None, lootType: str = None, isLootcrate: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 16, inv_cols: int = 8, persistent: int = 0, model: str = "IG_supplyCrate_F"):
    # PRINT_DEBUG(f"clientID: {clientID}\n"
    #       f"pos: {pos}\n"
    #       f"crateID: {crateID}\n"
    #       f"lootType: {lootType}\n"
    #       f"isLootcrate: {isLootcrate}\n"
    #       f"loot_count: {loot_count}\n"
    #       f"inv_rows: {inv_rows}\n"
    #       f"persistent: {persistent}\n"
    #       f"model: {model}\n")
    try:
        if persistent > 0:
            invData = sData.database.crates[crateID]
        else:
            invData = sData.database.sessionCrates[crateID]

        # ToDo: Add an "in use"-check (players, currently having that Inventory open)
        # send Inventory data back to the requesting client
        conClient = sData.user_active[clientID]["con"]
        PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_request: Crate found, sending Data to Client.")

        # send the invData to the Client
        inv_data_send_toClient(invData, conClient)
        return

    # No "Error", the crate was just not in the List. So let's create a new crate entry (Usage: loot/drop crates)
    except KeyError:
        PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_request: Creating new Crate")
        inv_data_create(sData=sData, clientID=clientID, pos=pos, crateID=crateID, lootType=lootType, isLootcrate=isLootcrate, loot_count=loot_count, inv_rows=inv_rows, inv_cols=inv_cols, persistent=persistent)
    except Exception:
        PRINT_WARNING(f"ERROR: INV_HANDLER: inv_data_request: HUGE WOBBLE WOBBLE! Data:\nclientID: {clientID}\npos: {pos}\ncrateID: {crateID}\nlootType: {lootType}\npersistent {persistent}\ninv_rows {inv_rows}\n---------")

# called by Server only!
def inv_data_create(sData, clientID: str = None, pos: list = None, crateID: str = "", lootType: str = None, isLootcrate: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 16, inv_cols: int = 8, persistent: int = 0, model: str = "IG_supplyCrate_F"):
    """
    :param sData:       ServerData (auto-passed)
    :param clientID:    A3 playerUID
    :param pos:         list - [[x,y,z],dir]
    :param crateID:
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
        PRINT_WARNING(f"ERROR: INV_HANDLER: inv_data_create: clientID or Pos not transmitted: clientID: {clientID} | pos: {pos}")
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

    invData = {
        "crateID":   crateID,
        "model":     model,
        "pos":       pos,
        "type":      lootType,
        'inventory': {
            "0": {
                "inv_rows": inv_rows,
                'inv_cols': inv_cols,
                "invID":    0,
                "invArea":  "an_inv_external_area",
                "invGrid":  "an_inv_external_grid",
                "slotsUsed": []
                }
            },
        "itemData":  {}
        }

    # PRINT_DEBUG(f"CRATE ADD:\n"
    #       f"crateID     : {crateID}\n"
    #       f"Model       : {model}\n"
    #       f"Pos         : {pos}\n"
    #       f"type        : {lootType}\n"
    #       f"inv_rows    : {inv_rows}\n"
    #       f"invData     : {invData}\n")

    # create the Inventory
    if persistent > 0:
        sData.database.crates[crateID] = invData
        asc_db.db_save(sData.database)
    else:
        # fill the lootcrate (if crate/Inventory is a lootcrate)
        if isLootcrate == 1:
            # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: isLootcrate: {isLootcrate}")

            skill_scavenging = sData.database.players[clientID]["skills"]["scavenging"]
            # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: skill_scavenging: {skill_scavenging}")

            # ToDo: recalculate the loot_count properly, based on the scavenging skill!
            # check if skill is high enough, otherwise randRange will complain, that the "end"-number isn't high enough... (must be "start < end")
            if skill_scavenging > 0:
                loot_count = random.randrange(loot_count, int(loot_count + (skill_scavenging * DEFAULT_loot_skill_multiplier)))
            # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: loot_count: {loot_count}")

            # get the list of Item names
            items_list = loot_handler.loot_item_list_create(sData=sData, crate_id=crateID, loot_count=loot_count, loot_type=lootType)
            # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: items_list_raw: {items_list}\n----------------")

            # cycle through all the parents (parent can either be full itemData or a subType)
            for parent in items_list:
                try:
                    # Check if the "parent" is a subType. If so: Get the parent-name from the subType
                    if parent in sData.itemSubTypes:
                        # create the Item Data structure
                        subType_parent = sData.itemSubTypes[parent]["parent"]
                        # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: subType_class: {parent} - subType_parent: {subType_parent}")

                        # create and get the Item Data structure
                        item = inv_item_create(parent=subType_parent)
                        # get the subTypeData of the desired Item
                        subType = sData.itemSubTypes[parent]
                        # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: subType: {subType} -  item: {item}")
                        # update the parentData with the subTypeData
                        item.update(subType)
                        # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create -> inv_item_create: item #2: {item}")
                        # ToDo: call a function in item_handler to update/calc stats like hp_cur, depending on... something

                    else:
                        item = inv_item_create(parent=parent)
                    # Add item to Inventory and update the invData
#############################################################
                    invData, item = inv_item_add_to_inv(sData=sData, invData=invData, isLootcrate=isLootcrate, item=item)
#############################################################
                # in case the item wasn't defined in parentData -> Create a default/fallback item
                except TypeError as e:
                    PRINT_WARNING(f'ERROR: INV_HANDLER: inv_data_create: ITEM DEFINITION NOT FOUND: Parent: "{parent}" - Creating dummy Icon')
                    # PRINT_WARNING(f"ERROR: INV_HANDLER: inv_data_create: Error: {e}")
                    item = inv_item_create(parent="PLACEHOLDER")
#############################################################
                    invData, item = inv_item_add_to_inv(sData=sData, invData=invData, isLootcrate=isLootcrate, item=item)
#############################################################
                except Exception as e:
                    PRINT_WARNING(f"ERROR: INV_HANDLER: inv_data_create: Error (HUGE WOBBLE WOBBLE): {e}")

            # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_data_create: invData: {invData}")

        # store in database, under temporary crates
        sData.database.sessionCrates[crateID] = invData
        # done

    # send Inventory data back to the requesting client
    conClient = sData.user_active[clientID]["con"]
    # send the invData to the Client
    inv_data_send_toClient(invData, conClient)




def inv_data_update_force(client, invID_old, invID_new):
    """
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
    if len(inv_remote) == 0:
        PRINT_WARNING(f"ERROR: inv_data_update_force: inv_remote not found!")
        return

    dataset = {
        "crateID": client.puid,
        "itemData": client.cData["itemData"],
        "inventory": client.cData["inventory"]
        }
    # update the player Gear
    asc_g_msg.sendMsg("player_gear_set", dataset, client.con_client)
    # Remove the dict entry: "inv_grid" (not needed on the client)
    stripped_inv_remote = inv_remote["inventory"]
    # send the stripped Remote Inventory back to the player and trigger the Inventory UI to be reopen, so it loads the new data
    inv_data_send_toClient(stripped_inv_remote, client.con_client)


def inv_item_check_size(size):
    # if given, check if X/Y are not < 1
    if size[0] < 1:
        size[0] = 1
    if size[1] < 1:
        size[1] = 1
    return size


def inv_item_add_to_inv(sData, invData=None, isLootcrate: int = 0, item=None, invGearID: str = "0"):
    """

    :param sData:
    :param invData:
    :param isLootcrate:
    :param item:
    :param invGearID:
    :return:
    """
    try:
        if None in [item, invData]:
            PRINT_WARNING(f"ERROR: inv_item_add_to_inv: item NOT found.\ninvID: {invData}\nitem: {item}------")
            return

        invGrid = invData["inventory"][invGearID]["inv_grid"]
        invSlotsUsed = invData["inventory"][invGearID]["slotsUsed"]
        inv_rows = invData["inventory"][invGearID]["inv_rows"]
        inv_cols = invData["inventory"][invGearID]["inv_cols"]
        inv_itemData = invData["itemData"]

        # get the parent Data
        item_parent_data = inv_item_parent_get(sData=sData, itemName=item["parent"])
        # check if parent Data is a subclass of a main Item definition
        try:
            if "parent" in item_parent_data:
                mainParentData = sData.itemParentData[item_parent_data["parent"]]
                mainParentData.update(item_parent_data)
                item_parent_data = mainParentData
        except TypeError:
            # Parent definition not found. Exit here and re-add a dummy/fallback Item instead (triggered by returning "none")
            return

        #########################################################
        # check if the DataSize is correct (e.g.: values > 0)
        if len(item_parent_data) == 0:
            PRINT_WARNING(f"ERROR: item_handler: inv_item_add_to_inv: item_parent_data NOT FOUND - item['parent']: {item['parent']}")
            return invData["inventory"][invGearID]

        x_size = inv_item_check_size(item_parent_data["size"])

        # keep count of how many rows will be added in the end (IF isLootcrate == 1)
        grid_rows_final = len(invGrid)

        # find free slots for the Item (if (AND ONLY IF) it is a temp Inventory -> Add more rows, if needed!)
        while True:
            slot_usage = inv_slots_free_get(invGrid=invGrid, item_size=x_size)
            if len(slot_usage) == 0:
                # PRINT_DEBUG(f"DEBUG: item_handler: inv_item_add_to_inv: No free slots found.")
                if isLootcrate > 0:
                    # PRINT_DEBUG(f"DEBUG: item_handler: inv_item_add_to_inv: It's a lootcrate -> Adding new row. Count: {grid_rows_final}\n-------------")
                    # add a new row to the tempInventory
                    newRow = [0] * inv_cols
                    invGrid.append(newRow)
                    grid_rows_final = len(invGrid)

                    if grid_rows_final > 75:
                        # seems like, that something went pretty wrong there
                        grid_rows_final = inv_rows
                        break
                else:
                    break
            else:
                # PRINT_DEBUG(f"DEBUG: item_handler: inv_item_add_to_inv: slot_usage: {slot_usage}")
                break

        # check if there were slots found
        if len(slot_usage) > 0:
            # update the Inventory Grid, its gridSize ...
            inv_slots_used_set(slots_used=slot_usage, invGrid=invGrid, isAdd=True)
            invData["inventory"][invGearID]["inv_grid"] = invGrid
            invData["inventory"][invGearID]["inv_rows"] = grid_rows_final
            invData["itemData"] = inv_itemData

            # ... and add the item to its itemData
            inv_itemData[item["id"]] = item

            # also update the items InventoryPosition. Set the first entry (top left corner) as inventoryPos...
            item["invPos"] = slot_usage[0]
            # ... and set the ID of the "crate"
            item["curInv"] = invData["crateID"]
        else:
            PRINT_WARNING(f"ERROR: item_add_list: No free slots found for x_ItemData:\n{item}\n inv_rows: {inv_rows}\n-------------")
        #########################################################

        # return the updated invData!
        # PRINT_DEBUG(f"DEBUG: item_handler: inv_item_add_to_inv: invData:\nDEBUG: {invData}\n----------------------")
        return [invData, item]

        # client.cData["itemData"][newItem["id"]] = newItem
        # PRINT_DEBUG(client.cData["itemData"])
        # # ToDo: TEMP! Saving will be done by an extra Thread from the Server! e.g. every 10 "pushes" OR every 10s -> save data to file
        # client.sData.database.db_save()
    except TypeError:
        PRINT_WARNING(f'--------------\nERROR: inv_item_add_to_inv: Error while getting parent definition for {item["parent"]} (undefined baseItem?) - Creating Dummy Item\n--------------')
        return
    except Exception as e:
        PRINT_WARNING(f"-------------\nERROR: item_add_list: EXCEPTION:\n{e}\n-------------")


def inv_item_parent_get(sData, itemName: str = None):
    if itemName is None:
        PRINT_WARNING(f"ERROR: inv_item_parent_get: NO itemName given!")
        return {}
    # get the parent-itemData
    try:
        if itemName in sData.itemParentData:
            return sData.itemParentData[itemName]
        elif itemName in sData.itemSubTypes:
            return sData.itemSubTypes[itemName]
    except Exception as e:
        PRINT_WARNING(f"ERROR: inv_item_parent_get: Exception:\nitemName: {itemName}\nException: {e}")


def inv_item_degrade(sData, user, itemType, *args):
    # slotID:
    # 0 Primary
    # 1 Handgun
    # 2 Secondary (launcher)
    if itemType == "wpn":
        slotID, ammoType, firemode, shots = args
        PRINT_DEBUG(f"DEBUG: inv_item_degrade - user: {user} - args: {args}"
              f"\nslotID   - {slotID}"
              f"\nfiremode - {firemode}"
              f"\nammoType - {ammoType}"
              f"\nshots - {shots}")
        PRINT_DEBUG(f"DEBUG: inv_item_degrade - userdata: {sData.database.players[user]}")


########################################################################
# NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW NEW #
######################################################################

########################################################################
# INV INV INV INV INV INV INV INV INV INV INV INV INV INV INV INV INV #
######################################################################

def inv_data_send_toClient(invData, conClient):
    # PRINT_ATTENTION(f"inv_data_send_toClient: invData: {invData}")
    dataset = {
        "crateID": invData["crateID"],
        "itemData": invData["itemData"],
        "inventory": invData["inventory"]
        }
    asc_g_msg.sendMsg("ret_inv_crateData", dataset, conClient)


def inv_slots_used_get(invData: dict, invSubID: str):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    ""
    :return:            [[0, 0], [0, 1], ...]
    """
    return invData[invSubID]["slotsUsed"]

def inv_slots_used_set(invData: dict, invSubID: str, slotsUsed: list):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    ""
    :param slotsUsed:   [[0, 0], [0, 1], ...]
    :return:            None
    """
    invData[invSubID]["slotsUsed"] = slotsUsed

def inv_slots_used_add(invData: dict, invSubID: str, slotsUsed: list):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    ""
    :param slotsUsed:   [[0, 0], [0, 1], ...]
    :return:            None
    """
    invData[invSubID]["slotsUsed"].extend(slotsUsed)

def inv_slots_used_remove(invData: dict, invSubID: str, slotsUsed: list):
    """
    :param invData:     invData["inventory"]
    :param invSubID:    ""
    :param slotsUsed:   [[0, 0], [0, 1], ...]
    :return:            None
    """
    slotsUsed_cur = invData[invSubID]["slotsUsed"]
    for slot in slotsUsed:
        if slot in slotsUsed_cur:
            print(invData[invSubID]["slotsUsed"])
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
        PRINT_WARNING(f'ERROR: INV_HANDLER: inv_data_remove crateID NOT FOUND - crateID: {crateID}')
    return


def inv_data_get(client, invID: str):
    # PRINT_ATTENTION(f"DEBUG: INV_HANDLER: inv_data_get invID : {invID}")
    try:
        # check if player Inventory (mostly used)
        if invID == client.puid:
            # PRINT_DEBUG(f"DEBUG: inv_data_get: isPlayer: True")
            return [client.cData, True]
        else:
            # Check if temporary/Session Crates (used while looting, so 2nd place)
            if invID in client.sData.database.sessionCrates:
                # PRINT_DEBUG(f"DEBUG: inv_data_get: isPlayer: False")
                return [client.sData.database.sessionCrates[invID], False]
            # Last chance: Check the persistent Inventories (most likely the less used from the 3 options)
            elif invID in client.sData.database.crates:
                # PRINT_DEBUG(f"DEBUG: inv_data_get: isPlayer: False")
                return [client.sData.database.crates[invID], False]
            else:
                PRINT_WARNING(f'ERROR: INV_HANDLER: inv_data_get invID NOT FOUND #1 - ID: {invID}')
                return [{}, False]
    except KeyError:
        PRINT_WARNING(f'ERROR: INV_HANDLER: inv_data_get invID NOT FOUND #2 - ID: {invID}')
        return [{}, False]
    except Exception as e:
        PRINT_WARNING(f'ERROR: INV_HANDLER: inv_data_get - UNKNOWN ERROR - ID: {invID}:\n{e}')
        return [{}, False]

##########################################################################
# ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM ITEM #
########################################################################

def item_data_flip_canFlip(size):
    if size[0] == size[1]:  # if a square -> No need to be flippable, so "0"
        return False
    else:
        return True


def item_data_create_base(parent: str = "", slot=0):
    """
    :param parent:      Base Item Data, the A3 UI can refer to
    :param slot:        subInventory (ONLY in player Inventory, currently! - "0" == External)
    :return:            itemData (dict)
    """

    item = {
        "id":           id_handler.create_id(),        # Item ID - Will ALWAYS be generated!
        "parent":       parent,      # Base Item Data, the A3 UI can refer to (stored ItemData)
        "hp_cur":       100,         # Current HP
        "hp_max":       100,         # Max HP
        "curInv":       "-1",        # ID of Inventory, that the Item is in
        "invSub":       slot,        # subInventory (ONLY in player Inventory, currently! - "0" == External)
        "invPos":       [0, 0],      # TopLeft Position of the Item in the InventoryGrid
        "isFlipped":    0,           # 0/1 - Check if Item was flipped
        "attachments":  {
            # "scope": "",            # TODO: determine what makes more sense: ItemID or full itemData?
            # "magazine": "",         # TODO: determine what makes more sense: ItemID or full itemData?
            # "muzzle": "",           # TODO: determine what makes more sense: ItemID or full itemData?
            # "barrel": "",           # TODO: determine what makes more sense: ItemID or full itemData?
            # "support": "",          # TODO: determine what makes more sense: ItemID or full itemData?
            },
        }

    return item


def inv_item_move(client=None, args=()):
    if client is None:
        PRINT_WARNING('ERROR: INV_HANDLER: ITEM_MOVE: "CLIENT" NOT PASSED')
        return False
    # PRINT_DEBUG(f"DEBUG: ITEM_MOVE: client: {client}")
    # PRINT_DEBUG(f"DEBUG: ITEM_MOVE: ARGS: {args}")
    try:
        # # invID_old/_new = either "getPlayerUID" for players OR "randomID" for Crates
        # # invSubID_old/_new = ID of SubInventory (e.g.: external (0) - Uniform (1012) - Vest (1013) - Pouch (1014) - Backpack (1015)
        # # args = [var1,var2, etc]
        itemID, invID_old, invSubID_old, invID_new, invSubID_new, invPos_new, isFlipped = args
        # PRINT_DEBUG(f"cData: {client.cData}")
    except Exception as e:
        PRINT_WARNING(f'ERROR: INV_HANDLER: ITEM_MOVE: Could NOT get Data from args:\n{e}\n')
        return False

    invData_old, isPlayer_old = inv_data_get(client, invID_old)
    invData_new, isPlayer_new = inv_data_get(client, invID_new)
    # Check: Both inventories were found
    if not invData_old or not isPlayer_new:
        PRINT_WARNING(f"WARNING: INV_HANDLER: inv_item_move: INVENTORY NOT FOUND:\ninvData_old: {invData_old}\ninvData_new:{invData_new}")
        return False

    moveWithinInv = isPlayer_old == isPlayer_new
    moveWithinInvSub = False
    if moveWithinInv:
        if invSubID_old == invSubID_new:
            moveWithinInvSub = True

    # Check: If "player to player" transfer (not implemented - Security Reasons - Maybe overkill? idk.. something for later to check again)
    if isPlayer_old and isPlayer_new and not moveWithinInv:
        PRINT_WARNING(f"WARNING: INV_HANDLER: inv_item_move: PLAYER TO PLAYER TRANSFER DETECTED:\nold: {invID_old}\nnew:{invID_new}")
        return False

    # Check: Item in old Inventory
    if itemID not in invData_old["itemData"]:
        PRINT_WARNING(f"WARNING: INV_HANDLER: inv_item_move: ITEM NOT FOUND IN OLD INVENTORY:\nold: {invID_old}\nnew:{invID_new}")
        return False

    #############################################
    # get itemData
    itemData = invData_old["itemData"][itemID]
    itemData_isFlipped = itemData["isFlipped"]

    # get Inventory sizes and make it an [row,col]-list
    invSize_old = [invData_old["inv_rows"], invData_old["inv_cols"]]
    invSize_new = [invData_new["inv_rows"], invData_new["inv_cols"]]

    #############################################
    # get the usedSlots
    usedSlots_old = inv_slots_used_get(invData=invData_old["inventory"], invSubID=invSubID_old)
    usedSlots_new = inv_slots_used_get(invData=invData_new["inventory"], invSubID=invSubID_new)

    # get the currently used slots:
    invOld_usedSlots = item_slots_used_calc(invDataSize=invSize_old, itemSize=itemData["size"], slotStart=itemData["invPos"], slotsUsed=usedSlots_old, slotsIgnore=usedSlots_old, isFlipped=itemData_isFlipped)

    # Check if Client just moves the Item around, inside the own Inventory
    if moveWithinInv and moveWithinInvSub:
        slotsIgnore = invOld_usedSlots
    else:
        slotsIgnore = []
    # check the new Inv, if there are enough slots free and return the newly blocked slots.
    invNew_usedSlots = item_slots_used_calc(invDataSize=invSize_new, itemSize=itemData["size"], slotStart=invPos_new, slotsUsed=usedSlots_new, slotsIgnore=slotsIgnore, isFlipped=isFlipped)

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
    itemData["invSub"] = invSubID_new
    itemData["invPos"] = invPos_new
    itemData["isFlipped"] = isFlipped
    itemData["curInv"] = invID_new
    # ... and add it to the new one
    invData_new["itemData"][itemData["id"]] = itemData

    # ToDo: Check if it was placed in a slot (:thonk:)
    # ToDo: Send loadout update, if it was placed in a slot
    # # submit: loadout
    # dataset = {
    #     "data_puid": client.puid,
    #     "data_gear": listGear
    #     }
    # asc_g_msg.sendMsg("player_loadout_set", dataset, client.sData.con_gameServer)

    # ToDo: TEMP! Saving will be done by an extra Thread from the Server!
    client.sData.database.db_save()


def item_slots_used_calc(invDataSize: list, itemSize: list, slotStart: list, slotsUsed: list, slotsIgnore: list, isFlipped: bool):
    """
    :param invDataSize:     [16, 8]
    :param itemSize:        [4, 4]
    :param slotStart:       [0, 0]
    :param slotsUsed:       [[0, 0], [0, 1], ...]
    :param slotsIgnore:     [[0, 0], [0, 1], ...]
    :param isFlipped:       True/False
    :return:                [[0, 0], [0, 1], ...] OR [] (nothing found)
    """
    if slotsIgnore is None:
        slotsIgnore = []

    invRows, invCols = invDataSize
    slotStartRow, slotStartCol = slotStart
    # in case the item was flipped 90° -> Col=Row, Row=Col
    if isFlipped:
        itemCols, itemRows = itemSize
    else:
        itemRows, itemCols = itemSize

    # Set the offset, to check only
    offset_row = slotStartRow + itemRows
    offset_col = slotStartCol + itemCols

    ret = []
    if offset_row > invRows or offset_col > invCols:
        PRINT_WARNING(f"ERROR: INV_HANDLER: inv_slots_free_find: ITEM EXCEEDS INVENTORY GRIDSPACE!")
        return ret

    isBlocked = False
    for row in range(slotStartRow, offset_row):
        for col in range(slotStartCol, offset_col):
            invSlot = [row, col]
            if invSlot in slotsUsed and invSlot not in slotsIgnore:
                PRINT_WARNING(f"ERROR: INV_HANDLER: inv_slots_free_find: SLOT IS BLOCKED!")
                isBlocked = True
                break
            ret.append(invSlot)
        if isBlocked:
            ret = []
            print(f"SLOT BLOCKED")
            break
    return ret


def item_slots_free_find(invDataSize: list, itemSize: list, slotsUsed: list, slotsIgnore: list, isFlipped: bool):
    """
    :param invDataSize:     [16, 8]
    :param itemSize:        [4, 4]
    :param slotsUsed:       [[0, 0], [0, 1], ...]
    :param slotsIgnore:     [[0, 0], [0, 1], ...]
    :param isFlipped:       True/False
    :return:                [[0, 0], [0, 1], ...] OR [] (nothing found)
    """
    invRows, invCols = invDataSize
    # in case the item was flipped 90° -> Col=Row, Row=Col
    if isFlipped:
        itemSize = [itemSize[1], itemSize[0]]

    ret = []
    slotFound = False
    for row in range(invRows):
        for col in range(invCols):
            invSlot = [row, col]
            ret = item_slots_used_calc(invDataSize=invDataSize, itemSize=itemSize, slotStart=invSlot, slotsUsed=slotsUsed, slotsIgnore=slotsIgnore, isFlipped=isFlipped)
            # if free slot found (filled list) -> exit for-loop
            if len(ret):
                slotFound = True
                break

        if slotFound:
            # print(f"free slots found - {ret}")
            break

    return ret





