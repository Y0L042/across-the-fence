/*
    File: ui_inv_EH_mouse_z.sqf
    Author: Dscha
    Date: 2020-10-15
    Last Update: 2020-12-06
    Public: No
    
    Description:
        Check if the mousePos is inside an Inventory. If so, scroll the Inventory Up or Downwards
    
    Parameter(s):
		0:	control (unused)	-	control
		1:	Scroll direction	-	FLOAT
    
    Returns:
		None
    
    Example(s):
		call an_c_fnc_ui_inv_EH_mouse_z;
*/

params ["_displayorcontrol", "_scroll"];

// determine, if the mousePos is inside an Inventory or Slot Area
private _invData = call an_c_fnc_ui_inv_get;
private _areaName = _invData get "invArea";
private _gridName = _invData get "invGrid";
private _isSlot = _invData get "isSlot";

// either nothing was found or it's a slot. Since Slots can't be scrolled in, exit too (for now at least, unless we find another use for it).
if((_isSlot == 0) && !(_areaName isEqualTo ""))then
{
	// systemchat str ["mouse_Z", _areaName, diag_tickTime];
	private _ctrlGrp_parent = uinamespace getvariable [_areaName, controlNull];
	private _ctrlGrp = uinamespace getvariable [_gridName, controlNull];
	
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
};