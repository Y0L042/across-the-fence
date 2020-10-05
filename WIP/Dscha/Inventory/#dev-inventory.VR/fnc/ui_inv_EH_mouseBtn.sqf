

//executed from grabbed Item ctrl
disableSerialization;
params ["_ctrl", "_btn", "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];


//RMB - Reset to old Pos
if(_btn == 1 && an_ui_inv_grabActive)then
{
	private _data_prev = _ctrl getVariable ["item_data_prev",[]];
	_data_prev params ["_ctrl_parent_prev","_p_x","_p_y","_item_class","_item_usedSlots_prev","_pos_data"];
	[_ctrl_parent_prev,0,_p_x,_p_y] call an_fnc_ui_inv_mPos;
	
	// trigger the deletion of the temp Item, AFTER mPos crated the "final" Item!
	an_ui_inv_grabActive = false;
};

//LMB - Place Item
if(_btn == 0)then
{
	_this call an_fnc_ui_inv_mPos_check;
};

//NEEDED!
true