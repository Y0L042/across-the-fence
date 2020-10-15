

//executed from grabbed Item ctrl
disableSerialization;
params ["_ctrl", "_btn", "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];


//RMB - Reset to old Pos
if(_btn == 1 && an_ui_inv_grabActive)then
{
	// re add the Item and its used slots in its previously used grid
	// Get the previous data
	private _data_prev = _ctrl getVariable ["item_data_prev",[]];
	diag_log ["_data_prev: ",_data_prev];
	_data_prev params ["_ctrl_parent_prev","_p_x","_p_y","_item_class","_item_usedSlots_prev","_pos_data"];
	
	private _grid_usedSlots = [(ctrlIDC _ctrl_parent_prev)] call an_c_fnc_ui_inv_grid_tiles_used_get;
	
	// add all tiles to the "blocked tiles"-array and store it in the Grid-parent itself
	[_ctrl_parent_prev,_grid_usedSlots,_item_usedSlots_prev] call an_c_fnc_ui_inv_grid_tiles_used_update;
	
	// create the Item again
	[_ctrl_parent_prev,0,[_p_x,_p_y]] call an_c_fnc_ui_inv_mPos;
	
	// trigger the deletion of the temp Item, AFTER mPos crated the "final" Item!
	an_ui_inv_grabActive = false;
};

//LMB - Place Item
if(_btn == 0)then
{
	_this call an_c_fnc_ui_inv_mPos_check;
};

//NEEDED!
true
