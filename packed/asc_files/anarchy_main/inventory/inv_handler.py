import random
from printHandler import *
from . import id_handler
from . import loot_handler
from asc_fnc.asc_db.database import asc_db
from asc_fnc import asc_g_msg


# Default Variables: (DEV/WIP? Put it somewhere else, idk yet)
DEFAULT_loot_count = 2
DEFAULT_loot_skill_multiplier = 2

# inventory = INT
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


        # ToDo: Add an "in use"-check
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
                "inv_grid": inv_grid_create(inv_rows, inv_cols),
                "inv_rows": inv_rows,
                'inv_cols': inv_cols
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
                    invData, item = inv_item_add_to_inv(sData=sData, invData=invData, isLootcrate=isLootcrate, item=item)

                # in case the item wasn't defined in parentData -> Create a default/fallback item
                except TypeError as e:
                    PRINT_WARNING(f'ERROR: INV_HANDLER: inv_data_create: ITEM DEFINITION NOT FOUND: Parent: "{parent}" - Creating dummy Icon')
                    # PRINT_WARNING(f"ERROR: INV_HANDLER: inv_data_create: Error: {e}")
                    item = inv_item_create(parent="PLACEHOLDER")
                    invData, item = inv_item_add_to_inv(sData=sData, invData=invData, isLootcrate=isLootcrate, item=item)
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


def inv_data_send_toClient(invData, conClient, invGridID="0"):
    # PRINT_ATTENTION(f"inv_data_send_toClient: invData: {invData}")
    dataset = {
        "itemData": invData["itemData"],
        "crateID": invData["crateID"],
        # "inventory": self.cData["inventory"]
        "inv_rows": invData["inventory"][invGridID]["inv_rows"],
        "inv_cols": invData["inventory"][invGridID]["inv_cols"]
        }
    asc_g_msg.sendMsg("ret_inv_crateData", dataset, conClient)


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
        "itemData": client.cData["itemData"],
        "inv_rows": client.cData["inventory"]["12"]["inv_rows"],    # TODO: DEV VALUE - Needs .sqf adjustments first!
        "inv_cols": client.cData["inventory"]["12"]["inv_cols"]     # TODO: DEV VALUE - Needs .sqf adjustments first!
        }
    # update the player Gear
    asc_g_msg.sendMsg("player_gear_set", dataset, client.con_client)
    # send Remote Inventory back to the player and trigger the Inventory UI to be reopen, so it loads the new data
    inv_data_send_toClient(inv_remote, client.con_client)


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


def inv_data_get(client, invID):
    # PRINT_ATTENTION(f'DEBUG: INV_HANDLER: inv_data_get invID : {invID}')
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


# usedSlots = slots occupied by the given Item Size INSIDE the invGrid!
def inv_slots_used_get(slotsStart=None, slots_ignore=None, sizeItem=None, invGrid=None, isFlipped=0, isAdd=True):
    if slots_ignore is None:
        slots_ignore = []
    if None in [slotsStart, sizeItem, invGrid]:
        return []

    slot_state_needed = 1
    if isAdd:
        slot_state_needed = 0

    xin, yin = slotsStart
    # PRINT_DEBUG(slots)
    if isFlipped == 0:
        xit, yit = sizeItem
    else:
        yit, xit = sizeItem
    # PRINT_DEBUG(size)
    slots_used = []
    try:
        for xpos in range(xit):
            for ypos in range(yit):
                try:
                    slot_state_cur = invGrid[xin+xpos][yin+ypos]
                    # check if slot is free (0 = free | 1 = used)
                    if slot_state_cur == slot_state_needed:
                        slots_used.append([xin+xpos, yin+ypos])
                    # Slot is taken, check if the Pos is in the ignore list:
                    elif [(xin+xpos), (yin+ypos)] in slots_ignore:
                        slots_used.append([xin+xpos, yin+ypos])
                    else:
                        # PRINT_DEBUG(f"DEBUG: INV_HANDLER: inv_slots_used_get - NO FREE SLOTS FOUND - Slot: {[xin+xpos, yin+ypos]} (If EQUIP REQUEST -> All is fine!)")
                        return []
                except IndexError:
                    PRINT_WARNING("ERROR: INV_HANDLER: inv_slots_used_get: Parts of the Item are outside the Inventory ")
                    return []
    except Exception as e:
        PRINT_WARNING(f'ERROR: INV_HANDLER: inv_slots_used_get - ERROR:\n{e}')
        return []
    # PRINT_DEBUG(f"slots_used: {slots_used}")
    return slots_used


def inv_slots_used_set(slots_used=None, invGrid=None, isAdd=True):
    if None in [slots_used, invGrid]:
        PRINT_WARNING(f'ERROR: INV_HANDLER: inv_slots_used_set - ERROR: slots_used: {slots_used} - invGrid: {invGrid}')
        return False

    # PRINT_DEBUG(f'DEBUG: INV_HANDLER: inv_slots_used_set - {len(slots_used)} - Slots: {slots_used}')
    if len(slots_used) == 0:
        return True

    if isAdd:
        slot_used_state = 1
    else:
        slot_used_state = 0

    # PRINT_DEBUG("free slots found")
    for index in range(len(slots_used)):
        x, y = slots_used[index]
        invGrid[x][y] = slot_used_state

    return True


def inv_slots_free_get(invGrid, item_size):
    # ToDo: Probably needs a full rework anyway (don't rly like it... but meh... works for now - maybe adding some kind of blacklist ala "this row is full, no need to check again)
    # ToDo: make a check if Item can be flipped and try to find space again (later)
    grid_rows = len(invGrid)
    grid_cols = len(invGrid[0])

    grid_rows_maxCheck = grid_rows - item_size[0]   # no need to check the x-axis further, if the height would be outside of bounds
    grid_cols_maxCheck = grid_cols - item_size[1]  # no need to check the y-axis further, if the width would be outside of bounds
    slots = []
    for x in range(0, grid_rows):
        if x > grid_rows_maxCheck:
            # max reached, return empty Array (triggers addRow (tempInventory) OR shows Error Message
            return []
        for y in range(0, grid_cols):
            if y > grid_cols_maxCheck:
                break
            slots = inv_slots_used_get(slotsStart=[x, y], sizeItem=item_size, invGrid=invGrid, isFlipped=0, isAdd=True)
            # if slots were found, exit the search/loop
            if len(slots) != 0:
                return slots
        # if slots were found, exit the search/loop
        if len(slots) != 0:
            return slots
    # Normally, this one should never trigger... but who knows /shrug
    return []


def inv_item_check_size(size):
    # if given, check if X/Y are not < 1
    if size[0] < 1:
        size[0] = 1
    if size[1] < 1:
        size[1] = 1
    return size


def inv_item_check_canFlip(size):
    if size[0] == size[1]:  # if a square -> No need to be flippable, so "0"
        return 0
    else:
        return 1

def inv_item_create(parent: str = "", slot=None, doSlot=False):
    """

    :param parent:
    :param slot:
    :param doSlot:
    :return:
    """

    if slot is None:
        slot = [0]
    item = {
        "id":           id_handler.create_id(),        # Item ID - Will ALWAYS be generated!
        "parent":       parent,           # Base Item Data, the A3 UI can refer to (stored ItemData)
        "hp_cur":       100,         # Current HP
        "hp_max":       100,         # Max HP
        "curInv":       "-1",        # ID of Inventory, that the Item is in
        "invSub":       "0",        # subInventory (in player Inv only!)
        "invPos":       [0, 0],      # TopLeft Position of the Item in the InventoryGrid
        "isFlipped":    0,           # 0/1 - Check if Item was flipped
        "inSlot":       0,           # 0-N - in which Slot is the Item in? (0 = normal inventory)
        "attachments":  {
            # "scope": "",            # TODO: determine what makes more sense: ItemID or full itemData?
            # "magazine": "",         # TODO: determine what makes more sense: ItemID or full itemData?
            # "muzzle": "",           # TODO: determine what makes more sense: ItemID or full itemData?
            # "barrel": "",           # TODO: determine what makes more sense: ItemID or full itemData?
            # "support": "",          # TODO: determine what makes more sense: ItemID or full itemData?
            },
        }

    if doSlot:
        # ToDo: recheck later, if a slotCheck is needed here
        item["inSlot"] = slot[0]

    return item


def inv_item_move(client=None, args=()):
    if client is None:
        PRINT_WARNING('ERROR: INV_HANDLER: ITEM_MOVE: "CLIENT" NOT PASSED')
        return
    # PRINT_DEBUG(f"DEBUG: ITEM_MOVE: client: {client}")
    # PRINT_DEBUG(f"DEBUG: ITEM_MOVE: ARGS: {args}")
    try:
        # # invID = either "getPlayerUID" for players OR "randomID" for Crates
        # # invGearID = Ground (0) - Uniform (12) - Vest (13) - Pouch (14) - Backpack (15)
        # # args = [var1,var2, etc]
        itemID, invID_old, invID_new, isFlipped, invPos, inSlot, invGearID = args
        # PRINT_DEBUG(f"cData: {client.cData}")
    except Exception as e:
        PRINT_WARNING(f'ERROR: INV_HANDLER: ITEM_MOVE: Could NOT get Data from args:\n{e}\n')
        return
    # PRINT_DEBUG(f"----------------")
    # PRINT_DEBUG(f"itemID      : {itemID}")
    # PRINT_DEBUG(f"invID_old   : {invID_old}")
    # PRINT_DEBUG(f"invID_new   : {invID_new}")
    # PRINT_DEBUG(f"isFlipped   : {isFlipped}")
    # PRINT_DEBUG(f"invPos      : {invPos}")
    # PRINT_DEBUG(f"invGearID   : {invGearID}")
    # PRINT_DEBUG(f"----------------")
    # PRINT_DEBUG(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")

    # get old Inventory + grid
    PRINT_ATTENTION(f"inv_item_move - PRE inv_data_get: invID_old: {invID_old}")
    oldInv, isPlayer = inv_data_get(client, invID_old)
    if len(oldInv) == 0:
        PRINT_WARNING(f"ERROR: inv_items_get: data not found!")
        return

    item = None
    invGearID_old = "0"
    # and the item data
    if itemID in oldInv["itemData"]:
        item = oldInv["itemData"][itemID]
        invGearID_old = oldInv["itemData"][itemID]["invSub"]

    # exit if item couldn't be added
    if item is None:
        PRINT_WARNING(f"ERROR: ITEM_MOVE: Key not found: {itemID}\nERROR: Resending Inventory update back to the player")
        # resending it, triggers a force-reopen of the Inventory (force reopen/load Inventory)
        inv_data_update_force(client=client, invID_old=invID_old, invID_new=invID_new)
        return
    # PRINT_DEBUG(f"::::: item:\n{item}")

    oldInv_invGrid = oldInv["inventory"][invGearID_old]["inv_grid"]

    # get the parent Data
    item_parent_data = inv_item_parent_get(sData=client.sData, itemName=item["parent"])

    sizeItem = item_parent_data["size"]

    # also get the new inventory + grid
    PRINT_ATTENTION(f"inv_item_move - PRE inv_data_get: invID_new: {invID_new}")
    newInv, isPlayer = inv_data_get(client, invID_new)
    if len(newInv) == 0:
        PRINT_WARNING(f"ERROR: inv_items_get: data not found!")
        return

    newInv_invGrid = newInv["inventory"][invGearID]["inv_grid"]

    isFlipped_cur = item["isFlipped"]
    inSlot_cur = item["inSlot"]

    # Prep vars, to check if an (un)equip request was send
    isEquip = False     # Inventory TO Slot?
    isUnEquip = False   # Slot TO Inventory?
    # check if the Items Slot has changed:
    if inSlot_cur != inSlot:
        if inSlot_cur == 0:
            # remove from Inv       = NO
            # set new used Slots    = Yes
            isEquip = True
        # Slot TO Inventory?
        if inSlot_cur != 0:
            # remove from Inv       = Yes
            # set new used Slots    = NO
            isUnEquip = True

    # get pos in old invGrid and check if everything is correct there
    slots_used_old = inv_slots_used_get(slotsStart=item["invPos"], invGrid=oldInv_invGrid, isFlipped=isFlipped_cur, sizeItem=sizeItem, isAdd=False)

    # Check if the item used slots. In case of unequipping -> Ignore
    if len(slots_used_old) == 0 and not isUnEquip:
        PRINT_WARNING("INVENTORY: Something was wrong with the old Item State - no blocked tiles found")
        inv_data_update_force(client=client, invID_old=invID_old, invID_new=invID_new)
        return

    # PRINT_DEBUG(f"--------------------\n  EQUIP REQUEST: {isEquip} - UNEQUIP REQUEST: {isUnEquip}\n--------------------")
    # Check if the old Inv is the new Inv (moving Item inside an Inventory) ignore the previously used slots then.
    if invID_old == invID_new:
        # get currently used slots, ignoring the previously used slots
        slots_used_new = inv_slots_used_get(slotsStart=invPos, slots_ignore=slots_used_old, invGrid=newInv_invGrid, isFlipped=isFlipped, sizeItem=sizeItem, isAdd=True)
    else:
        # check for free slots
        slots_used_new = inv_slots_used_get(slotsStart=invPos, invGrid=newInv_invGrid, isFlipped=isFlipped, sizeItem=sizeItem, isAdd=True)

    # PRINT_DEBUG(f"::::: slots_used: {slots_used_new}")

    # check if there was enough space in the new Inventory. In case of Equip: Ignore
    if len(slots_used_new) == 0 and not isEquip:
        PRINT_WARNING("INVENTORY: Item can NOT be added")
        inv_data_update_force(client=client, invID_old=invID_old, invID_new=invID_new)
        return
    else:
        # and remove it from the old Inventory Grid, if its not coming from a Slot
        if not isUnEquip:
            inv_slots_used_set(slots_used=slots_used_old, invGrid=oldInv_invGrid, isAdd=False)
        # also delete from "itemData" dict
        del oldInv["itemData"][itemID]

        # update Item
        item["invPos"] = invPos
        item["curInv"] = invID_new
        if isPlayer:
            # Assign the ID, in which the Item is placed in (12 = Uniform - 13 = Vest - 14 = Pouch - 15 Backpack)
            # using the "isPlayer"-result from the "newInv" data request
            item["invSub"] = invGearID
        else:
            # In case of external (e.g. Ground/Crate) Inventory: 0
            item["invSub"] = "0"
        item["isFlipped"] = isFlipped
        item["inSlot"] = inSlot

        # set the used slots in the new Inventory Grid, if it is NOT an "Equip"-request!
        if not isEquip:
            inv_slots_used_set(slots_used=slots_used_new, invGrid=newInv_invGrid, isAdd=True)

        # and add it to the new Inventory itemData
        newInv["itemData"][item["id"]] = item
        # PRINT_DEBUG(newInv["itemData"])

        # To finalize it: Check if its an (un)equip request and update the player, if needed.
        if isEquip or isUnEquip:
            # filter out all the equipped Gear and send it as a "special" set to the Server, so the Client can be equipped
            listGear = []
            for x in client.cData["itemData"]:
                # noinspection PyTypeChecker
                slotID = client.cData["itemData"][x]["inSlot"]
                if slotID > 0:
                    listGear.append(client.cData["itemData"][x])
            # submit: loadout
            dataset = {
                "data_puid": client.puid,
                "data_gear": listGear
                }
            asc_g_msg.sendMsg("player_loadout_set", dataset, client.sData.con_gameServer)

    # ToDo: TEMP! Saving will be done by an extra Thread from the Server!
    client.sData.database.db_save()


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