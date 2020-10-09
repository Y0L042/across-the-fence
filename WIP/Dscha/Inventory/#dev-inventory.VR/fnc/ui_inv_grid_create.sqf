/*
	create a grid in given controlGroup

*/


#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

params["_disp","_ctrlGrp","_size_y"];

private _grid_w = (ctrlPosition _ctrlGrp)#2;
private _grid_h = ((_grid_w / 0.75) / an_inv_size_col) * _size_y;	//adjust to 4/3 Value - 8 == fixed grid amout
// diag_log ["GRID_CREATE: ", _grid_h, _grid_w];
private _tile_H = _grid_h/_size_y;


// adjust the height of the ctrlGroup (grid)
_ctrlGrp ctrlSetPositionH _grid_h;
_ctrlGrp ctrlCommit 0;

// adjust the height of the CtrlGroup-parent of the used grid - unless it exceeds the base value - Info: used in: ui_inv_mPos_check_mouse_z
private _ctrlGrp_area = (ctrlParentControlsGroup _ctrlGrp);
if(_grid_h < (ctrlPosition _ctrlGrp_area)#3)then
{
	_ctrlGrp_area ctrlSetPositionH _grid_h;
	_ctrlGrp_area ctrlCommit 0;
};

//also of the Background (DEV IDC)
private _ctrlGrp_bg = _ctrlGrp controlsGroupCtrl 99999;
_ctrlGrp_bg ctrlSetPositionH _grid_h;
_ctrlGrp_bg ctrlCommit 0;


// create the "row"-images, inside the given _ctrlGrp
for "_p_y" from 0 to (_size_y-1)do
{
	// use its Y Coord as IDC
	private _idc = _p_y;
	// add it to the "inventory"-area
	private _ctrl = _disp ctrlCreate ["tile_base",_idc,_ctrlGrp];
	_ctrl ctrlSetposition [0,(_tile_H*_p_y),_grid_w,_tile_H];
	_ctrl ctrlCommit 0;
};

missionNameSpace setVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrp)], _size_y];
diag_log ["DEBUG: ui_inv_grid_create: size: ", missionNameSpace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrp)],[]]];