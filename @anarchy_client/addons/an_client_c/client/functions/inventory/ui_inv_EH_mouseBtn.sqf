
private _DEBUGON = false;
//executed from grabbed Item ctrl
disableSerialization;
params ["_ctrl", "_btn", "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];


//RMB - Reset to old Pos
if(_btn == 1 && an_ui_inv_grabActive)then
{
	
	if(isNull _ctrl)exitWith{systemchat "ERROR: EH_MouseBTN: (isNull _ctrl)";};
	
	// re add the Item and its used slots in its previously used grid
	// Get the previous data
	private _itemID = _ctrl getVariable "itemID";
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _itemID        : ",_itemID];};
	
	private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _itemData      : ",_itemData];};
	
	private _itemPos = _itemData get "invPos";
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _itemPos       : ",_itemPos];};
	
	private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _parentData    : ",_parentData];};
	
	private _invSubPrev = _itemData get "invSub";
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _invSubPrev    : ",_invSubPrev];};
	
	private _invDataPrev = AN_data_inventory get "inventory" get _invSubPrev;
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _invDataPrev   : ",_invDataPrev];};
	
	private _ctrlInvGrid = uinamespace getVariable [(_invDataPrev get "invGrid"), controlNull];
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _ctrlInvGrid   : ",_ctrlInvGrid];};
	
	// transform from grid to ui-pos
	([_invDataPrev, _itemPos ]call an_c_fnc_ui_inv_grid_gridToPos) params["_posX","_posY"];
	// create it again
	[_ctrlInvGrid,_posX,_posY,_itemID] call an_c_fnc_ui_inv_item_create;
	
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
