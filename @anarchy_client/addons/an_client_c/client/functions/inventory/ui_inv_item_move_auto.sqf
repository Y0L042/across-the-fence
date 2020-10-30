/*
	Auto move the Item the opposite Inventory (Shift+LMB on an Item)
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btnShift", "_btnCtrl", "_btnAlt"];

// Get the ctrlGroupParent, to determine in which Inventory the selected Item is, then select the opposite Inventory
//																		External					Personal
_invTarget = if(ctrlIDC (ctrlParentControlsGroup _ctrl) == 1000)then{AN_INVENTORY_LIST#1}else{AN_INVENTORY_LIST#0};
_invTarget params ["_areaName","_gridName"];

_ctrlGrid = uinamespace getvariable [_gridName,ControlNull];

// Get all the blocked Slots of the target Inventory
private _gridUsedSlots = [(ctrlIDC _ctrlGrid)] call an_c_fnc_ui_inv_grid_tiles_used_get;
diag_log ["DEBUG: MOVE_AUTO: _gridUsedSlots :", _gridUsedSlots];

private _itemData = [_ctrl] call an_c_fnc_ui_inv_item_data_get;
_itemData params ["_posData","_itemUsedSlots","_itemClass","_itemId"];
// Note: _itemUsedSlots == slots in current Inventory

// Get the Parent Data for the selected Item
private _parentData = [_itemClass] call an_c_fnc_ui_inv_item_data_parent_get;
private _parentSize = ENTRY_GET("size",_parentData);
diag_log ["DEBUG: MOVE_AUTO: _parentSize    :", _parentSize];

// Get the inventory Gridsize (rows only, since width is fixed) of the Inventory target
private _invSize = localNamespace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrid)], 4];

// We only need to check those Slots, which would be still inside Grid. e.g.: Column > (GridWidthSlots-ItemWidthSlots) == Don't even check that.
private _invSizeCol = _ctrlGrp getVariable ["an_sizeCol", 8];
private _rowMax = _invSize-(_parentSize#0)+1;
private _colMax = _invSizeCol-(_parentSize#1)+1;
diag_log [_rowMax, _colMax];


// Currently used Slots:
private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_slots_usage_get;
diag_log ["DEBUG: MOVE_AUTO: _itemSlotUsage:", _itemSlotUsage];

_slots = [_rowMax, _colMax, _itemSlotUsage, _gridUsedSlots] call an_c_fnc_ui_inv_item_slots_find_free;
diag_log ["DEBUG: MOVE_AUTO: _slots          : ", _slots];

// No free slots found, exiting.
if(_slots isEqualTo [])exitWith{diag_log "No free slots found.";};


//convert from gridPos to uiPos
([_ctrlGrid, _invSize, (_slots#0) ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];

// set the ID and Classname, to create the Item
[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
[_itemId] call an_c_fnc_ui_inv_item_active_id_set;

[_ctrlGrid, 0, [_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;

// delete the old control
[_ctrl] call an_c_fnc_ui_inv_item_remove;