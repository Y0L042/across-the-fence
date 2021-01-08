disableSerialization;

private _DEBUGON = false;

// #include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btnShift", "_btnCtrl", "_btnAlt"];


// Shift = Move to the other Inventory (incl. finding a suitable position in the Grid)
if(_btnShift && _btn == 0)exitWith{[_ctrl] call an_c_fnc_ui_inv_item_move_auto};
// Ctrl = Automove to Slot, if free.
if(_btnCtrl && _btn == 0)exitWith{[_ctrl] call an_c_fnc_ui_inv_item_move_auto_slot};


if(an_ui_inv_grabActive)exitWith{systemchat "an_ui_inv_grabActive already active";};
an_ui_inv_grabActive = true;

private _itemID = _ctrl getVariable "itemID";
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GRAB: _itemID       :", _itemID];};

private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GRAB: _itemData     :", _itemData];};

// Get the Parent Data for the selected Item
private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GRAB: _parentData   :", _parentData];};

// RMB
if(_btn in [1])exitWith
{
	// systemchat str ["_parentData", _parentData];
	private _actions = _parentData get "parentData" getOrDefault ["actions",[]];
	{
		_x params["_tag","_fncData"];
		_fncData params ["_name","_functionName","_execMode","_params"];
		// Example: _fncData = ["use MediKit","an_fnc_MediKit_use",0,[]]
		// Example: _fncData = ["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]
		systemchat str [_x];
		private _fnc = missionNameSpace getVariable [_functionName,{}];
		if(_execMode == 0)then	{[_ctrl] call _fnc;}
		else					{[_ctrl] spawn _fnc;};
	}forEach _actions;
	// systemchat str ["DEV: _actions", _actions#0];
	an_ui_inv_grabActive = false;
};


// ToDo: Move to separate function?
private _invSubIdCur = _itemData get "invSub";
private _invData = AN_data_inventory get "inventory" get _invSubIdCur;
(_itemData get "invPos") params ["_tileRow","_tileCol"];
private _parentSize = _parentData get "baseData" get "size";
private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_space_usage_get;

private _isFlipped = _itemData get "isFlipped";
private _offsetPos = [[_tileRow, _tileCol]];	//store first Pos (needed, since the offset will determined from this position)
{
	_x params["_posRow","_posCol"];
	if(_isFlipped == 0)then
	{
		_offsetPos pushbackUnique [ (_tileRow + _posRow), (_tileCol + _posCol) ];
	}else{
		_offsetPos pushbackUnique [ (_tileRow + _posCol), (_tileCol + _posRow) ];
	};
}forEach _itemSlotUsage;

// Remove the currently used slots, so it can be placed at the same Slots it has used before:
[_invSubIdCur,_offsetPos] call an_c_fnc_ui_inv_grid_tiles_used_remove;


// Create the ItemIcon:
private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
private _ctrlGrpItem = _disp ctrlCreate ["inv_icon",32123];

// Recalculate the Size of the Item, in case it was taken from a Slot (Slot == different Width/Height, than normal Grid)
private _ctrlInvGrid = uinamespace getvariable ["an_inv_uni_grid", controlNull];
([_parentSize, _ctrlInvGrid] call an_c_fnc_ui_inv_item_size_calc) params ["_ctrlItemW","_ctrlItemH"];
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GRAB: ctrl W/H      :", [_ctrlItemW, _ctrlItemH]];};

_ctrlGrpItem ctrlSetPosition[0,0, _ctrlItemW, _ctrlItemH];
_ctrlGrpItem ctrlCommit 0;
_ctrlGrpItem ctrlAddEventhandler ["MouseButtonUp","call an_c_fnc_ui_inv_EH_mouseBtn"];

private _ctrlImgPrev = _ctrl controlsGroupCtrl 200;
{
	private _ctrlSub = _ctrlGrpItem controlsGroupCtrl _x;
	_ctrlSub ctrlSetposition [0,0,_ctrlItemW,_ctrlItemH];
	_ctrlSub ctrlCommit 0;
	if(_x == 200)then
	{
		_ctrlSub ctrlSetText (ctrlText _ctrlImgPrev);
	};
}forEach[100,200];
_ctrlGrpItem setVariable ["itemID", _itemID];


// delete the old control
_ctrl spawn {ctrlDelete _this;};


// "Attach" the newly created ItemControl to the Mouse
uinamespace setVariable ["an_ctrl_active", _ctrlGrpItem];
addMissionEventHandler ["Draw3D",{[] call an_c_fnc_ui_inv_item_attachToMouse;}];





