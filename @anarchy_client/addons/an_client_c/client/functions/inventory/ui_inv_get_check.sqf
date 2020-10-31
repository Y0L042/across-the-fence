/*
	Check if the mPos is inside the given control (argument passed: Varname)
*/

params	[
			["_ctrl_varName","",[""]]
		];

private _ctrl_toCheck = uinamespace getvariable [_ctrl_varName, controlNull];
if(isNull _ctrl_toCheck)then{systemchat str["ERROR: mPos_check_inAray: ControlVar not found! Varname:", _ctrl_varName];};

(ctrlPosition _ctrl_toCheck) params["_cPos_pInv_x","_cPos_pInv_y","_cPos_pInv_w","_cPos_pInv_h"];
private _cPos_pInv_w_half = _cPos_pInv_w / 2;
private _cPos_pInv_h_half = _cPos_pInv_h / 2;

private _coords_player_inv = [[_cPos_pInv_x + _cPos_pInv_w_half, _cPos_pInv_y + _cPos_pInv_h_half], _cPos_pInv_w_half, _cPos_pInv_h_half, 0, true];

//return if mPos is in
(getMousePosition inArea _coords_player_inv)