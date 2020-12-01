disableSerialization;

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_ctrl", "_btn", "_xPos", "_yPos", "_btnShift", "_btnCtrl", "_btnAlt"];




// Shift = Move to the other Inventory (incl. finding a suitable position in the Grid)
if(_btnShift && _btn == 0)exitWith{_this call an_c_fnc_ui_inv_item_move_auto};
// Ctrl = Automove to Slot, if free.
if(_btnCtrl && _btn == 0)exitWith{_this call an_c_fnc_ui_inv_item_move_auto_slot};

if(an_ui_inv_grabActive)exitWith{systemchat "an_ui_inv_grabActive already active";};
an_ui_inv_grabActive = true;

private _itemData = [_ctrl] call an_c_fnc_ui_inv_item_data_get;
_itemData params ["_posData","_itemUsedSpace","_itemClass","_itemID"];

// Get the Parent Data for the selected Item
private _parentData = [_itemClass] call an_c_fnc_ui_inv_item_data_parent_get;

// DEV: Block everything, except Left Mousebutton
if(_btn in [1])exitWith
{
	an_ui_inv_grabActive = false;
	// systemchat str ["_parentData", _parentData];
	private _actions = ENTRY_GET("actions",_parentData);
	{
		_x params["_tag","_fncData"];
		_fncData params ["_name","_functionName","_execMode","_params"];
		// Example: _fncData = ["use MediKit","an_fnc_MediKit_use",0,[]]
		// Example: _fncData = ["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]
		systemchat str ["_name: ",_name];
		// systemchat str ["_functionName: ",_functionName];
		// systemchat str ["_execMode: ",_execMode];
		// systemchat str ["_params: ",_params];
		private _fnc = missionNameSpace getVariable [_functionName,{}];
		if(_execMode == 0)then	{[_ctrl] call _fnc;}
		else					{[_ctrl] spawn _fnc;};
	}forEach _actions;
	systemchat str ["DEV: _actions", _actions#0];
};


[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
[_itemID] call an_c_fnc_ui_inv_item_active_id_set;
(ctrlPosition _ctrl) params["_pX","_pY","",""];

// Recalculate the Size of the Item, in case it was taken from a Slot (Slot == different Width/Height, than normal Grid)
private _ctrlInvGrid = uinamespace getvariable ["an_inv_player_grid", controlNull];
([_parentData, _ctrlInvGrid] call an_c_fnc_ui_inv_item_size_calc) params ["_pW","_pH"];

private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
private _ctrlGrpItem = _disp ctrlCreate ["inv_icon",32123];

_ctrlGrpItem ctrlSetPosition[0,0, _pW, _pH];
_ctrlGrpItem ctrlCommit 0;
_ctrlGrpItem ctrlAddEventhandler ["MouseButtonUp","call an_c_fnc_ui_inv_EH_mouseBtn"];

private _ctrlImgPrev = _ctrl controlsGroupCtrl 200;
{
	private _ctrlSub = _ctrlGrpItem controlsGroupCtrl _x;
	_ctrlSub ctrlSetposition [0,0,_pW,_pH];
	_ctrlSub ctrlCommit 0;
	if(_x == 200)then
	{
		_ctrlSub ctrlSetText (ctrlText _ctrlImgPrev);
	};
}forEach[100,200];


// make a "copy" of the usedSlots array, so it won't be deleted, when removing the ctrl (pointing to it)
private _itemUsedSpacePrev = +_itemUsedSpace;
_ctrlGrpItem setVariable ["item_data_prev",[(ctrlParentControlsGroup _ctrl), _pX, _pY, _itemClass, _itemUsedSpacePrev]];

// delete the old control
[_ctrl] call an_c_fnc_ui_inv_item_remove;

uinamespace setVariable ["an_ctrl_active", _ctrlGrpItem];
addMissionEventHandler ["Draw3D",{[] call an_c_fnc_ui_inv_item_attachToMouse;}];
