/*
	Used for Drag&Drop Events! (EH MB Down/UP don't work/trigger propery while MB is keeping pressed)

*/

params ["_ctrl_item", "_btn", "_mPos_x", "_mPos_y", "_btn_shift", "_btn_ctrl", "_btn_alt"];

// RMB
if(_btn == 1)exitWith{};

// LMB
if(_btn == 0)exitWith
{
	// determine, if the mousePos is inside an Inventory or Slot Area
	(call an_c_fnc_ui_inv_get) params ["_area","_grid","_isSlot"];
	
	// either nothing was found or it's a slot. Since Slots can't be scrolled in, exit too (for now at least, unless we find another use for it).
	if(_area isEqualTo "")exitWith{systemchat "ERROR: mPos_check: (_area isEqualTo "")";};
	
	// private _ctrlArea = uinamespace getvariable [_area, controlNull];
	private _ctrlGrid = uinamespace getvariable [_grid, controlNull];
	private _mPos_rel = ctrlMousePosition _ctrlGrid;
	[_ctrlGrid,_btn,_mPos_rel,_btn_shift,_btn_ctrl,_btn_alt] call an_c_fnc_ui_inv_mpos;
};
