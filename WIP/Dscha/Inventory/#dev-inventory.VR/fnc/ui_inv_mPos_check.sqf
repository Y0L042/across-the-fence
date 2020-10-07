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
	{
		_x params ["_area","_grid"];
		private _isIn = [_area] call an_fnc_ui_inv_mPos_check_inInv;
		
		if(_isIn)exitWith
		{
			private _ctrlGrp_parent = uinamespace getvariable [_area, controlNull];
			private _ctrlGrp = uinamespace getvariable [_grid, controlNull];
			private _mPos_rel = ctrlMousePosition _ctrlGrp;
			[_ctrlGrp,_btn,_mPos_rel,_btn_shift,_btn_ctrl,_btn_alt] call an_fnc_ui_inv_mpos;
		};
	}forEach[
				 ["an_inv_player_area","an_inv_player_grid"]
				,["an_inv_crate_area","an_inv_crate_grid"]
			];
};
