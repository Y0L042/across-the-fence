/*
	Auto move the Item the opposite Inventory (Shift+LMB on an Item)
*/
private _DEBUGON = false;
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btnShift", "_btnCtrl", "_btnAlt"];

// Get the ctrlGroupParent, to determine in which Inventory the selected Item is, then select the opposite Inventory
// In case of a slot -> Select the Personal Inventory!
////////////////////////////////
// If "gridAutoTgt" is not set -> "External" or a Slot is selected. So let's move the Item to the Uniform Inventory (for now)
private _gridName = (ctrlParentControlsGroup _ctrl) getVariable ["gridAutoTgt",""];
if(_gridName isEqualTo "")then{_gridName = "an_inv_uni_grid"};
private _ctrlGrid = uinamespace getvariable [_gridName, ControlNull];
if(isNull _ctrlGrid)exitWith{systemchat "ERROR: item_move_auto: GRID NOT FOUND!";};

// Get all the blocked Slots of the target Inventory
private _gridUsedSlots = [(ctrlIDC _ctrlGrid)] call an_c_fnc_ui_inv_grid_tiles_used_get;
if(_DEBUGON)then{diag_log ["DEBUG: MOVE_AUTO: _gridUsedSlots :", _gridUsedSlots];};

private _itemData = [_ctrl] call an_c_fnc_ui_inv_item_data_get;
_itemData params ["_posData","_itemUsedSlots","_itemClass","_itemId"];
// Note: _itemUsedSlots == slots in current Inventory

// Get the Parent Data for the selected Item
private _parentData = [_itemClass] call an_c_fnc_ui_inv_item_data_parent_get;
private _parentSize = ENTRY_GET("size",_parentData);
if(_DEBUGON)then{diag_log ["DEBUG: MOVE_AUTO: _parentSize    :", _parentSize];};

// Get the inventory Gridsize (rows only, since width is fixed) of the Inventory target
private _gridSize = localNamespace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrid)], [-1,-1]];
_gridSize params["_gridRows","_gridCols"];

// We only need to check those Slots, which would be still inside Grid. e.g.: Column > (GridWidthSlots-ItemWidthSlots) == Don't even check that.
private _rowMax = _gridRows-(_parentSize#0);
private _colMax = _gridCols-(_parentSize#1);
if(_DEBUGON)then{diag_log [_rowMax, _colMax];};


// Currently used Slots:
private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_space_usage_get;
if(_DEBUGON)then{diag_log ["DEBUG: MOVE_AUTO: _itemSlotUsage:", _itemSlotUsage];};
if(_DEBUGON)then{systemchat str ["DEBUG: MOVE_AUTO: _itemSlotUsage:", _itemSlotUsage];};

_slots = [_rowMax, _colMax, _itemSlotUsage, _gridUsedSlots] call an_c_fnc_ui_inv_item_space_find_free;
if(_DEBUGON)then{diag_log ["DEBUG: MOVE_AUTO: _slots          : ", _slots];};
if(_DEBUGON)then{systemchat str ["DEBUG: MOVE_AUTO: _slots          : ", _slots];};

// No free slots found, exiting.
if(_slots isEqualTo [])exitWith{systemchat "ERROR: item_move_auto: No free slots found.";};


//convert from gridPos to uiPos
([_ctrlGrid, _gridRows, (_slots#0) ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];

// set the ID and Classname, to create the Item
[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
[_itemId] call an_c_fnc_ui_inv_item_active_id_set;

[_ctrlGrid, 0, [_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;

// delete the old control
[_ctrl] call an_c_fnc_ui_inv_item_remove;