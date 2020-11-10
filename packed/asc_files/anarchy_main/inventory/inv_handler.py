import random

from . import id_handler
from asc_fnc.asc_db.database import asc_db
from asc_fnc import asc_g_msg

from . import item_handler

# Default Variables: (DEV/WIP? Put it somewhere else, idk yet)
DEFAULT_loot_count = 2
DEFAULT_loot_skill_multiplier = 2

# inventory = INT
def invGrid_create(rows):
    ret = []
    for x in range(rows):
        _line = [0] * 8
        ret.append(_line)
    return ret


# try to get the Crate data. If not found -> Create a new one. We simply assume the Data, coming from the Game-server, is correct/valid.
def crate_data_get(sData, clientID: str = None, pos: list = None, crateID: str = None, lootType: str = None, isLootcrate: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 4, persistent: int = 0, model: str = "IG_supplyCrate_F"):
    print(f"clientID: {clientID}\n"
          f"pos: {pos}\n"
          f"crateID: {crateID}\n"
          f"lootType: {lootType}\n"
          f"isLootcrate: {isLootcrate}\n"
          f"loot_count: {loot_count}\n"
          f"inv_rows: {inv_rows}\n"
          f"persistent: {persistent}\n"
          f"model: {model}\n")
    try:
        if persistent > 0:
            invData = sData.database.crates[crateID]
        else:
            invData = sData.database.sessionCrates[crateID]

        # ToDo: Add an "in use"-check
        # send Inventory data back to the requesting client
        conClient = sData.user_active[clientID]["con"]
        print(f"DEBUG: INV_HANDLER: crate_data_get: Crate found, sending Data to Client.")

        # send the invData to the Client
        inv_send_toClient(invData, conClient)
        return

    # No "Error", the crate was just not in the List. So let's create a new crate entry
    except KeyError:
        print(f"DEBUG: INV_HANDLER: crate_data_get: Creating new Crate")
        crate_add(sData=sData, clientID=clientID, pos=pos, crateID=crateID, lootType=lootType, isLootcrate=isLootcrate, loot_count=loot_count, inv_rows=inv_rows, persistent=persistent)
    except Exception:
        print(f"ERROR: INV_HANDLER: crate_data_get: HUGE WOBBLE WOBBLE! Data:\nclientID: {clientID}\npos: {pos}\ncrateID: {crateID}\nlootType: {lootType}\npersistent {persistent}\ninv_rows {inv_rows}\n---------")

# called by Server only!
def crate_add(sData, clientID: str = None, pos: list = None, crateID: str = "", lootType: str = None, isLootcrate: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 4, persistent: int = 0, model: str = "IG_supplyCrate_F"):
    """
    :param sData:       ServerData (auto-passed)
    :param clientID:    A3 playerUID
    :param pos:         list - [[x,y,z],dir]
    :param crateID:
    :param lootType:    String - type of loot, passed by the gameserver
    :param isLootcrate: is the crate a newly created Loot-crate or not
    :param loot_count:  Int - amount of Items to add (can be altered by Loot-skill of the player)
    :param inv_rows:    Int - Rows
    The following arguments are ONLY for creating persistent crates:
    :param persistent:  Save to Database or not (persistent crates only)
    :param model:       A3 typeOf Class (persistent crates only)
    :return:
    """

    if None in [clientID, pos]:
        print(f"ERROR: INV_HANDLER: create_add: clientID or Pos not transmitted: clientID: {clientID} | pos: {pos}")
        return

    if persistent > 0:
        # only persistent Crates store the model
        model = model
    else:
        model = ""

    if isLootcrate == 0:
        # Player created Crates (e.g: Opening Inventory to drop things)
        inv_rows = 16

    invData = {
        "crateID": crateID,
        "model": model,
        "pos": pos,
        "type": lootType,
        "inv_grid": invGrid_create(inv_rows),
        "inv_rows": inv_rows,    # rows
        "itemData": {}
        }

    print(f"CRATE ADD:\n"
          f"crateID     : {crateID}\n"
          f"Model       : {model}\n"
          f"Pos         : {pos}\n"
          f"type        : {lootType}\n"
          f"inv_rows    : {inv_rows}\n"
          f"invData     : {invData}\n")

    # create the Inventory
    if persistent > 0:
        sData.database.crates[crateID] = invData
        asc_db.db_save(sData.database)
    else:
        # fill the lootcrate (if crate/Inventory is a lootcrate)
        if isLootcrate == 1:
            print(f"DEBUG: INV_HANDLER: crate_add: isLootcrate: {isLootcrate}")

            skill_scavenging = sData.database.players[clientID]["skills"]["scavenging"]
            print(f"DEBUG: INV_HANDLER: crate_add: skill_scavenging: {skill_scavenging}")

            # ToDo: recalculate the loot_count properly, based on the scavenging skill!
            # check if skill is high enough, otherwise randRange will complain, that the "end"-number isn't high enough... (must be "start < end")
            if skill_scavenging > 0:
                loot_count = random.randrange(loot_count, int(loot_count + (skill_scavenging * DEFAULT_loot_skill_multiplier)))
            print(f"DEBUG: INV_HANDLER: crate_add: loot_count: {loot_count}")

            # get the list of Item names
            items_list = item_handler.loot_item_list_create(sData=sData, crate_id=crateID, loot_count=loot_count, loot_type=lootType)
            print(f"DEBUG: INV_HANDLER: crate_add: items_list_raw: {items_list}\n----------------")

            # cycle through all the parents (parent can either be full itemData or a subType)
            for parent in items_list:
                try:
                    # Check if the "parent" is a subType. If so: Get the parent-name from the subType
                    if parent in sData.itemSubTypes:
                        # create the Item Data structure
                        subType_parent = sData.itemSubTypes[parent]["parent"]
                        print(f"DEBUG: INV_HANDLER: crate_add: subType_class: {parent} - subType_parent: {subType_parent}")

                        # create and get the Item Data structure
                        item = item_handler.item_create(parent=subType_parent)
                        # get the subTypeData of the desired Item
                        subType = sData.itemSubTypes[parent]
                        print(f"DEBUG: INV_HANDLER: crate_add: subType: {subType} -  item: {item}")
                        # update the parentData with the subTypeData
                        item.update(subType)
                        print(f"DEBUG: INV_HANDLER: crate_add -> item_create: item #2: {item}")
                        # ToDo: call a function in item_handler to update/calc stats like hp_cur, depending on... something
                    else:
                        item = item_handler.item_create(parent=parent)

                    # Add item to Inventory and update the invData
                    invData, item = item_handler.item_add_to_inv(sData=sData, invData=invData, isLootcrate=isLootcrate, item=item)

                # in case the item wasn't defined in parentData -> Create a default/fallback item
                except Exception as e:
                    print(f"ERROR: INV_HANDLER: create_add: ITEM DEFINITION NOT FOUND: {parent} - Creating dummy Icon")
                    item = item_handler.item_create(parent="PLACEHOLDER")
                    invData, item = item_handler.item_add_to_inv(sData=sData, invData=invData, isLootcrate=isLootcrate, item=item)
            print(f"DEBUG: INV_HANDLER: crate_add: invData: {invData}")

        # store in database, under temporary crates
        sData.database.sessionCrates[crateID] = invData
        # done

    try:
        # send Inventory data back to the requesting client
        conClient = sData.user_active[clientID]["con"]

        # send the invData to the Client
        inv_send_toClient(invData, conClient)
    except KeyError:
        print(f"ERROR: INV_HANDLER: create_add: clientID NOT FOUND in user_active: {clientID}")


def inv_send_toClient(invData, conClient):
    # remove the inv_grid from the data, since we don't need it on the Client
    invData_noGrid = dict(invData)
    del invData_noGrid["inv_grid"]
    asc_g_msg.sendMsg("ret_inv_crateData", invData_noGrid, conClient)

def inv_update_force(client, invID_old, invID_new):
    """
    cData       client Data
    invID_old   "" - ID #1
    invID_new:  "" - ID #2
    """

    # Since we want to send over the remote Inventory -> Check if invID_old is NOT the player Inv.
    if invID_old != client.puid:
        inv_remote = inv_getData(client, invID_old)
    else:
        inv_remote = inv_getData(client, invID_new)
    # resending it, triggers a force-reopen of the Inventory (instantly)
    dataset = {
        "itemData": client.cData["itemData"],
        "inv_grid": client.cData["inv_grid"]
        }
    # update the player Gear
    asc_g_msg.sendMsg("player_gear_set", dataset, client.con_client)
    # send Remote Inventory back to the player and trigger the Inventory UI to be reopen, so it loads the new data
    inv_send_toClient(inv_remote, client.con_client)


# called by Server only!
def crate_rem(sData, createID, pos):
    crate = sData.database.crates[createID]
    # kind of security check
    if crate["pos"] == pos:
        del crate


def inv_getData(client, invID):

    try:
        # check if player Inventory (mostly used)
        if invID == client.puid:
            return client.cData
        else:
            # Check if temporary/Session Crates (used while looting, so 2nd place)
            try:
                return client.sData.database.sessionCrates[invID]
            # Last try: Check the persistent Inventories (most likely the less used from the 3 options)
            except KeyError:
                try:
                    return client.sData.database.crates[invID]
                except KeyError:
                    print('ERROR: INV_HANDLER: inv_getData NOT FOUND')
                    return
    except KeyError:
        print('ERROR: INV_HANDLER: inv_getData NOT FOUND')
        return
    except Exception as e:
        print(f'ERROR: INV_HANDLER: inv_getData - UNKNOWN ERROR:\n{e}')
        return


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
    # print(slots)
    if isFlipped == 0:
        xit, yit = sizeItem
    else:
        yit, xit = sizeItem
    # print(size)
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
                        print(f"DEBUG: INV_HANDLER: inv_slots_used_get - NO FREE SLOTS FOUND - Slot: {[xin+xpos, yin+ypos]} (If EQUIP REQUEST -> All is fine!)")
                        return []
                except IndexError:
                    print("Parts of the Item are outside the Inventory ")
                    return []
    except Exception as e:
        print(f'ERROR: INV_HANDLER: inv_slots_used_get - ERROR:\n{e}')
        return []
    print(f"slots_used: {slots_used}")
    return slots_used


def inv_slots_used_set(slots_used=None, invGrid=None, isAdd=True):
    if None in [slots_used, invGrid]:
        print(f'ERROR: INV_HANDLER: inv_slots_used_set - ERROR: slots_used: {slots_used} - invGrid: {invGrid}')
        return False

    # print(f'DEBUG: INV_HANDLER: inv_slots_used_set - {len(slots_used)} - Slots: {slots_used}')
    if len(slots_used) == 0:
        return True

    if isAdd:
        slot_used_state = 1
    else:
        slot_used_state = 0

    # print("free slots found")
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


def inv_grid_get(client=None, args=()):
    print('FUNCTION CALLED BY REMOTE: "inv_get_grid"')
    gridID = args[0]

    data = inv_getData(client, gridID)["inv_grid"]
    print(f"gridID: {gridID}\ndata: {data}")

    con = client.con_client
    asc_g_msg.sendMsg("ret_inv_get_grid", data, con)


def inv_items_get(client=None, args=()):
    print('FUNCTION CALLED BY REMOTE: "inv_get_items"')
    gridID = args[0]

    data = inv_getData(client, gridID)["itemData"]
    print(f"gridID: {gridID}\ndata: {data}")

    con = client.con_client
    asc_g_msg.sendMsg("ret_inv_get_items", data, con)

