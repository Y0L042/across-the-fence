
params ["_displayorcontrol", "_scroll"];
//only check, if an Item is being moved ("is grabbed")
if(an_ui_inv_grabActive)then
{
	private _ctrlGrp = controlNull;
	private _ctrlGrp_parent = controlNull;
	// check if: Player Inventory
	{
		_x params ["_area","_grid"];
		private _isIn = [_area] call an_fnc_ui_inv_mPos_check_inInv;
		if(_isIn)then
		{
			_ctrlGrp_parent = uinamespace getvariable [_area, controlNull];
			_ctrlGrp = uinamespace getvariable [_grid, controlNull];
		};
	}forEach [
				["an_inv_player_area","an_inv_player_grid"],
				["an_inv_crate_area","an_inv_crate_grid"]
			];
	
	if(!isNull _ctrlGrp_parent)then
	{
		// Get the base size values
		_ctrl_h_max = (ctrlPosition _ctrlGrp_parent)#3;
		_ctrl_h_cur = (ctrlPosition _ctrlGrp)#3;
		_tileSize = _ctrl_h_max / 20;	// 20 = max visible rows per Inventory
		_diff = parseNumber ((_ctrl_h_cur - _ctrl_h_max) toFixed 2);
		
		// Leave if there is no Scrollbar
		if(_diff == 0)exitWith{};
		
		// calc the scroll step, each "step" is one tile
		_scrollstep = 1 / (_diff / _tileSize);
		if(_scroll < 0)then{_scrollstep = _scrollstep * -1};
		
		// get the current "pos" of the scrollbar
		_scrollbar_pos = (ctrlScrollValues _ctrlGrp_parent)#0;
		
		// Add the new step
		_scrollbar_pos_new = _scrollbar_pos - _scrollstep;
		_scrollvalue = linearConversion [0, 1, _scrollbar_pos_new, 0, 1, true];
		
		// Set the Scrollbar:
		_ctrlGrp_parent ctrlSetScrollValues [_scrollvalue, -1];
		// _ctrlGrp ctrlCommit 0;
	};
};