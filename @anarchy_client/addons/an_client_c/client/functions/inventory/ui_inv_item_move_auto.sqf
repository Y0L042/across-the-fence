/*
	Auto move the Item the opposite Inventory (Shift+LMB on an Item)
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];

// Get the ctrlGroupParent, to determine in which Inventory the selected Item is, then select the opposite Inventory
_inv_target = if(ctrlIDC (ctrlParentControlsGroup _ctrl) == 1000)then{AN_INVENTORY_LIST#1}else{AN_INVENTORY_LIST#0};
_inv_target params ["_area","_grid"];

_ctrl_grid = uinamespace getvariable [_grid,ControlNull];

// Get all the blocked Slots of the target Inventory
private _grid_usedSlots = [(ctrlIDC _ctrl_grid)] call an_c_fnc_ui_inv_grid_tiles_used_get;
diag_log ["DEBUG: MOVE_AUTO: _grid_usedSlots :", _grid_usedSlots];

private _item_data = [_ctrl] call an_c_fnc_ui_inv_item_data_get;
_item_data params ["_pos_data","_item_usedSlots","_item_class","_item_id"];
// Note: _item_usedSlots == slots in current Inventory

// Get the Parent Data for the selected Item
private _parent_data = [_item_class] call an_c_fnc_ui_inv_item_data_parent_get;
private _parent_size = ENTRY_GET("size",_parent_data);
diag_log ["DEBUG: MOVE_AUTO: _parent_size    :", _parent_size];

// Get the inventory Gridsize (rows only, since width is fixed) of the Inventory target
private _inv_size = localNamespace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrl_grid)], 4];

// We only need to check those Slots, which would be still inside Grid. e.g.: Column > (GridWidthSlots-ItemWidthSlots) == Don't even check that.
private _row_max = _inv_size-(_parent_size#0)+1; 		// Both start at "Index 1", so no -1 needed
private _col_max = an_inv_size_col-(_parent_size#1)+1;	// Both start at "Index 1", so no -1 needed
diag_log [_row_max, _col_max];


// Currently used Slots:
private _item_slot_usage = [_parent_size] call an_c_fnc_ui_inv_item_slots_usage_get;
diag_log ["DEBUG: MOVE_AUTO: _item_slot_usage:", _item_slot_usage];

_slots = [_row_max, _col_max, _item_slot_usage, _grid_usedSlots] call an_c_fnc_ui_inv_item_slots_find_free;
diag_log ["DEBUG: MOVE_AUTO: _slots          : ", _slots];

// No free slots found, exiting.
if(_slots isEqualTo [])exitWith{diag_log "No free slots found.";};


//convert from gridPos to uiPos
([_ctrl_grid, _inv_size, (_slots#0) ]call an_c_fnc_ui_inv_grid_gridToPos) params["_item_pos_y","_item_pos_x"];

// set the ID and Classname, to create the Item
[_item_class] call an_c_fnc_ui_inv_item_active_class_set;
[_item_id] call an_c_fnc_ui_inv_item_active_id_set;

[_ctrl_grid, 0, [_item_pos_y,_item_pos_x]] call an_c_fnc_ui_inv_mPos;

// delete the old control
[_ctrl] call an_c_fnc_ui_inv_item_remove;