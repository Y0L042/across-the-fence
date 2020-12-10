/*
    File: ui_inv_get_check.sqf
    Author: Dscha
    Date: 2020-10-31
    Last Update: 2020-12-09
    Public: Yes
    
    Description:
        Check if the mPos is inside the given Ctrl Area
    
    Parameter(s):
		0:	STR		-	varname of the grid "AREA"
    
    Returns:
		BOOL
    
    Example(s):
		["an_inv_uni_area"] call an_c_fnc_ui_inv_get_check;
*/
params	[
			["_ctrl_varName_area","",[""]]
		];

private _ctrl_toCheck = uinamespace getvariable [_ctrl_varName_area, controlNull];
if(isNull _ctrl_toCheck)then{systemchat str["ERROR: mPos_check_inAray: ControlVar not found! Varname:", _ctrl_varName_area];};

(ctrlPosition _ctrl_toCheck) params["_cPos_pInv_x","_cPos_pInv_y","_cPos_pInv_w","_cPos_pInv_h"];
private _cPos_pInv_w_half = _cPos_pInv_w / 2;
private _cPos_pInv_h_half = _cPos_pInv_h / 2;

private _coords_player_inv = [[_cPos_pInv_x + _cPos_pInv_w_half, _cPos_pInv_y + _cPos_pInv_h_half], _cPos_pInv_w_half, _cPos_pInv_h_half, 0, true];

//return if mPos is in
(getMousePosition inArea _coords_player_inv)