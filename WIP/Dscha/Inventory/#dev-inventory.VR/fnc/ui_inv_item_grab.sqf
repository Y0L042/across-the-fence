disableSerialization;


params ["_ctrl", "_btn", "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];

// DEV: Block everything, except Left Mousebutton
if !(_btn in [0])exitWith{};

if(an_ui_inv_grabActive)exitWith{systemchat "an_ui_inv_grabActive already active";};
an_ui_inv_grabActive = true;

(_ctrl getVariable ["item_data",[]]) params ["_pos_data","_item_usedSlots","_item_class"];
// systemchat str [(_ctrl getVariable ["item_data",[]])];
(ctrlPosition _ctrl) params["_p_x","_p_y","_p_w","_p_h"];
missionNameSpace setVariable ["an_inv_itemActive",_item_class];

getMousePosition params["_mPos_x","_mPos_y"];
private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
private _ctrlGrp_item = _disp ctrlCreate ["inv_icon",32123];

private _offset_x = _p_x - _xPos;
private _offset_y = _p_y - _yPos;
// _ctrlGrp_item ctrlSetPosition[_mPos_x+_offset_x,_mPos_y+_offset_y, _p_w, _p_h];
_ctrlGrp_item ctrlSetPosition[0,0, _p_w, _p_h];
_ctrlGrp_item ctrlCommit 0;
_ctrlGrp_item ctrlAddEventhandler ["MouseButtonUp","call an_fnc_ui_inv_EH_mouseBtn"];

private _ctrl_img_old = _ctrl controlsGroupCtrl 200;
{
	private _ctrl_sub = _ctrlGrp_item controlsGroupCtrl _x;
	_ctrl_sub ctrlSetposition [0,0,_p_w,_p_h];
	_ctrl_sub ctrlCommit 0;
	if(_x == 200)then
	{
		_ctrl_sub ctrlSetText (ctrlText _ctrl_img_old);
	};
}forEach[100,200];


// make a "copy" of the usedSlots array, so it won't be deleted, when removing the ctrl (pointing to it)
private _item_usedSlots_prev = +_item_usedSlots;
_ctrlGrp_item setVariable ["item_data_prev",[(ctrlParentControlsGroup _ctrl), _p_x, _p_y, _item_class, _item_usedSlots_prev]];

// delete the old one
[_ctrl] call an_fnc_ui_inv_item_remove_DEV;

uinamespace setVariable ["an_ctrl_active", _ctrlGrp_item];
addMissionEventHandler ["Draw3D",{[] call an_fnc_ui_inv_item_attachToMouse;}];
