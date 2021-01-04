/*
	Used for Drag&Drop Events! (EH MB Down/UP don't work/trigger propery while MB is keeping pressed)

*/
private _DEBUGON = true;

params ["_ctrl_item", "_btn", "_mPos_x", "_mPos_y", "_btn_shift", "_btn_ctrl", "_btn_alt"];

// RMB
if(_btn == 1)exitWith{};

// LMB
if(_btn == 0)exitWith
{
	// determine, if the mousePos is inside an Inventory or Slot Area
	private _invData = call an_c_fnc_ui_inv_get;
	_gridName = _invData get "invGrid";
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS_CHECK: _gridName    : ",_gridName];};
	
	// either nothing was found or it's a slot. Since Slots can't be scrolled in, exit too (for now at least, unless we find another use for it).
	if(_gridName isEqualTo "")exitWith{systemchat "ERROR: mPos_check: (_area isEqualTo "")";};
	
	// private _ctrlArea = uinamespace getvariable [_area, controlNull];
	private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS_CHECK: _ctrlGrid    : ",_ctrlGrid];};
	private _mPos_rel = ctrlMousePosition _ctrlGrid;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS_CHECK: _mPos_rel    : ",_mPos_rel];};
	
	private _itemID = _ctrl_item getVariable "itemID";
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS_CHECK: _itemID      : ",_itemID];};
	
	[_ctrlGrid, _mPos_rel, _itemID] call an_c_fnc_ui_inv_mPos;
};
