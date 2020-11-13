/*
	Auto move the Item the correct Slot (Ctrl+LMB on an Item)
*/
private _DEBUGON = false;
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btnShift", "_btnCtrl", "_btnAlt"];


private _itemData = [_ctrl] call an_c_fnc_ui_inv_item_data_get;
_itemData params ["_posData","_itemUsedSlots","_itemClass","_itemId"];
// Note: _itemUsedSlots == slots in current Inventory

// Get the Parent Data for the selected Item
private _parentData = [_itemClass] call an_c_fnc_ui_inv_item_data_parent_get;
private _parentSize = ENTRY_GET("size",_parentData);
private _parentSlotID = ENTRY_GET("slot",_parentData);
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _parentSize     :", _parentSize]; diag_log _msg, systemchat str _msg;};
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _parentSlotID   :", _parentSlotID]; diag_log _msg, systemchat str _msg;};


// Get the Slot Grid, by using the slotID + 2100/2000 (IDC + SlotID == Slot Grid control))
private _disp = uiNamespace getVariable ["an_inventory",displayNull];
private _ctrlGrid = _disp displayCtrl (2100+_parentSlotID) controlsGroupCtrl (2000+_parentSlotID);
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _ctrlGrid   :", _ctrlGrid]; diag_log _msg, systemchat str _msg;};
if(isNull _ctrlGrid)exitWith{};

// Get all the blocked Slots of the target Inventory
private _gridUsedSlots = [(ctrlIDC _ctrlGrid)] call an_c_fnc_ui_inv_grid_tiles_used_get;
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _gridUsedSlots   :", _gridUsedSlots]; diag_log _msg, systemchat str _msg;};
if!(_gridUsedSlots isEqualTo [])exitWith{systemchat "Slot is already occupied";};

// Get the inventory Gridsize (rows only, since width is fixed) of the Inventory target
private _gridSize = localNamespace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrid)], [-1,-1]];
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _gridSize   :", _gridSize]; diag_log _msg, systemchat str _msg;};
_gridSize params["_gridRows","_gridCols"];

// We only need to check those Slots, which would be still inside Grid. e.g.: Column > (GridWidthSlots-ItemWidthSlots) == Don't even check that.
private _rowMax = _gridRows-(_parentSize#0);
private _colMax = _gridCols-(_parentSize#1);
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _rowMax, _colMax :", _rowMax, _colMax]; diag_log _msg, systemchat str _msg;};

// Currently used Slots:
private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_space_usage_get;
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _itemSlotUsage   :", _itemSlotUsage]; diag_log _msg, systemchat str _msg;};

_slots = [_rowMax, _colMax, _itemSlotUsage, _gridUsedSlots] call an_c_fnc_ui_inv_item_space_find_free;
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _slots   :", _slots]; diag_log _msg, systemchat str _msg;};

// No free slots found, exiting.
if(_slots isEqualTo [])exitWith{systemchat "ERROR: item_move_auto: No free slots found.";};

//convert from gridPos to uiPos
([_ctrlGrid, _gridRows, (_slots#0) ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];
if(_DEBUGON)then{private _msg = ["DEBUG: MOVE_AUTO_SLOT: _itemPosY, _itemPosX :", _itemPosY, _itemPosX]; diag_log _msg, systemchat str _msg;};


// set the ID and Classname, to create the Item
[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
[_itemId] call an_c_fnc_ui_inv_item_active_id_set;

[_ctrlGrid, 0, [_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;

// delete the old control
[_ctrl] call an_c_fnc_ui_inv_item_remove;