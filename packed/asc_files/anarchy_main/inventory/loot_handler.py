import random
from printHandler import *

def loot_item_type_select(sData, x_dict, DEBUG_itemInfo=None):
    if DEBUG_itemInfo is None:
        DEBUG_itemInfo = []

    # select random item
    selected_type = random.choices(list(x_dict), weights=list(x_dict.values()), k=1)[0]
    # PRINT_DEBUG(f"DEBUG: loot_item_type_select: selected_type: {selected_type}")
    DEBUG_itemInfo.append(selected_type)
    # check if selected_type exists other wise return class
    if selected_type in sData.lootData["tables"]:
        # PRINT_DEBUG(f"DEBUG: DEBUG_itemInfo: {DEBUG_itemInfo}")
        return loot_item_type_select(sData, sData.lootData["tables"][selected_type], DEBUG_itemInfo)
    else:
        # PRINT_DEBUG(f"DEBUG: loot_item_type_select: selected_type: {selected_type}")
        return selected_type


def loot_item_list_create(sData, loot_type, loot_count):
    """
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP

    :param sData:       OBJ - Main serverData
    :param loot_type:   STR - Which loot-table should be loaded
    :param loot_count:  INT - Amount of Items to be created
    :return:            Array with itemNames. Example: ["item1", "item2"]
    """

    # initial_seed = f"{sData.lootData['globalseed']} - {crate_id} - {loot_type}"
    # PRINT_DEBUG(f"DEBUG: loot_item_list_create: initial_seed: {initial_seed}")

    # list of item names
    loot_list = []
    # check if loot_type exists
    if loot_type in sData.lootData["tables"]:
        for x in range(loot_count):
            # start with the "type"
            loot_list.append(loot_item_type_select(sData, sData.lootData["tables"][loot_type]))

    # return the loot_list array with the their item-names
    return loot_list
    # ############################# NOTE:
    # PRINT_DEBUG(loot_item_list_create("98372491", "type_military", 3))
