/*
	Used for Drag&Drop Events! (EH MB Down/UP don't work/trigger propery while MB is keeping pressed)

*/

params ["_ctrl_item", "_btn", "_mPos_x", "_mPos_y", "_btn_shift", "_btn_ctrl", "_btn_alt"];

// RMB
if(_btn == 1)exitWith{};

// LMB
if(_btn == 0)exitWith
{
	systemchat str ["mPos_check: ",_btn];
	// determine, if the mousePos is inside an Inventory Area
	private _invActive = call an_c_fnc_ui_inv_mPos_get_inv;
	// ToDo: Change to: "isNotEqualTo", when introduced
	if!(_invActive isEqualTo ["",""])exitWith
	{
		_invActive params ["_area","_grid"];
		private _ctrlGrp_parent = uinamespace getvariable [_area, controlNull];
		private _ctrlGrp = uinamespace getvariable [_grid, controlNull];
		private _mPos_rel = ctrlMousePosition _ctrlGrp;
		[_ctrlGrp,_btn,_mPos_rel,_btn_shift,_btn_ctrl,_btn_alt] call an_c_fnc_ui_inv_mpos;
	};
};
