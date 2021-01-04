disableSerialization;

private _DEBUGON = true;

// #include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btnShift", "_btnCtrl", "_btnAlt"];


private _itemID = _ctrl getVariable "itemID";
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GRAB: _itemID       :", _itemID];};

// Shift = Move to the other Inventory (incl. finding a suitable position in the Grid)
if(_btnShift && _btn == 0)exitWith{[_itemID] call an_c_fnc_ui_inv_item_move_auto};
// Ctrl = Automove to Slot, if free.
if(_btnCtrl && _btn == 0)exitWith{[_itemID] call an_c_fnc_ui_inv_item_move_auto_slot};

if(an_ui_inv_grabActive)exitWith{systemchat "an_ui_inv_grabActive already active";};
an_ui_inv_grabActive = true;

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



(ctrlPosition _ctrl) params["_pX","_pY","",""];

// Recalculate the Size of the Item, in case it was taken from a Slot (Slot == different Width/Height, than normal Grid)
private _ctrlInvGrid = uinamespace getvariable ["an_inv_uni_grid", controlNull];
private _itemSize = _parentData get "baseData" get "size";
([_itemSize, _ctrlInvGrid] call an_c_fnc_ui_inv_item_size_calc) params ["_ctrlItemW","_ctrlItemH"];
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GRAB: ctrl W/H      :", [_ctrlItemW, _ctrlItemH]];};


private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
private _ctrlGrpItem = _disp ctrlCreate ["inv_icon",32123];

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

// Attach the newly created ItemControl to the Mouse
uinamespace setVariable ["an_ctrl_active", _ctrlGrpItem];
addMissionEventHandler ["Draw3D",{[] call an_c_fnc_ui_inv_item_attachToMouse;}];






