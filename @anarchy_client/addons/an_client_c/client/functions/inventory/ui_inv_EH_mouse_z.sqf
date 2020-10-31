
params ["_displayorcontrol", "_scroll"];
//only check, if an Item is being moved ("is grabbed")
if(an_ui_inv_grabActive)then
{
	// determine, if the mousePos is inside an Inventory or Slot Area
	(call an_c_fnc_ui_inv_get) params ["_area","_grid","_isSlot"];
	
	// either nothing was found or it's a slot. Since Slots can't be scrolled in, exit too (for now at least, unless we find another use for it).
	if(_isSlot || (_area isEqualTo ""))exitWith{};
	
	// systemchat str ["mouse_Z", _area, diag_tickTime];
	private _ctrlGrp_parent = uinamespace getvariable [_area, controlNull];
	private _ctrlGrp = uinamespace getvariable [_grid, controlNull];
	
	// Get the base size values
	private _ctrl_h_max = (ctrlPosition _ctrlGrp_parent)#3;
	private _ctrl_h_cur = (ctrlPosition _ctrlGrp)#3;
	private _tileSize = _ctrl_h_max / 20;	// 20 = max visible rows per Inventory
	private _diff = parseNumber ((_ctrl_h_cur - _ctrl_h_max) toFixed 2);
	
	// Leave if there is no Scrollbar
	if(_diff == 0)exitWith{};
	
	// calc the scroll step, each "step" is one tile
	private _scrollstep = 1 / (_diff / _tileSize);
	if(_scroll < 0)then{_scrollstep = _scrollstep * -1};
	
	// get the current "pos" of the scrollbar
	private _scrollbar_pos = (ctrlScrollValues _ctrlGrp_parent)#0;
	
	// Add the new step
	private _scrollbar_pos_new = _scrollbar_pos - _scrollstep;
	private _scrollvalue = linearConversion [0, 1, _scrollbar_pos_new, 0, 1, true];
	
	// Set the Scrollbar:
	_ctrlGrp_parent ctrlSetScrollValues [_scrollvalue, -1];
	// _ctrlGrp ctrlCommit 0;
};