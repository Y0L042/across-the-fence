
params ["_displayorcontrol", "_scroll"];
//only check, if an Item is being moved ("is grabbed")
if(an_ui_inv_grabActive)then
{
	// Main ctrlGroup
	private _isIn_player = ["an_inv_player_area"] call an_fnc_ui_inv_mPos_check_inInv;
	
	if(_isIn_player)exitWith
	{
		// ctrlGroup child (the stuff that moves)
		_inv_player_area = uinamespace getvariable ["an_inv_player_area", controlNull];
		_inv_player_grid = uinamespace getvariable ["an_inv_player_grid", controlNull];
		
		// get the pos of the scrollbar and add x% to it, depending on the size of the child
		_scrollbar_pos = (ctrlScrollValues _inv_player_area)#0;
		_scrollbar_pos_new = _scrollbar_pos - (_scroll / 12);
		_scrollvalue = linearConversion [0, 1, _scrollbar_pos_new, 0, 1, true];
		
		// Set the Scrollbar:
		systemchat str [_scrollvalue];
		_inv_player_area ctrlSetScrollValues [_scrollvalue, -1];
	};
	
	private _isIn_crate = ["an_inv_crate_area"] call an_fnc_ui_inv_mPos_check_inInv;
	if(_isIn_crate)exitWith
	{
		systemchat str ["DEBUG: CRATE AREA"];
	};
};