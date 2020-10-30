/*
	create a grid in given controlGroup

*/


#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

params["_ctrlGrid","_gridSize"];
_gridSize params["_gridRows","_gridCols"];

private _disp = uiNamespace getVariable ["an_inventory",displayNull];
if(isNull _disp)exitWith{};

private _gridW = (ctrlPosition _ctrlGrid)#2;
private _gridH = ((_gridW / 0.75) / _gridCols) * _gridRows;	//adjust to 4/3 Value
// diag_log ["GRID_CREATE: ", _gridH, _gridW];
private _tileH = _gridH/_gridRows;


// adjust the height of the ctrlGroup (grid)
_ctrlGrid ctrlSetPositionH _gridH;
_ctrlGrid ctrlCommit 0;

// adjust the height of the CtrlGroup-parent of the used grid - unless it exceeds the base value - Info: used in: ui_inv_mPos_check_mouse_z
private _ctrlGridArea = (ctrlParentControlsGroup _ctrlGrid);
if(_gridH < (ctrlPosition _ctrlGridArea)#3)then
{
	_ctrlGridArea ctrlSetPositionH _gridH;
	_ctrlGridArea ctrlCommit 0;
};

//also of the Background (DEV IDC)
private _ctrlGridBg = _ctrlGrid controlsGroupCtrl 99999;
_ctrlGridBg ctrlSetPositionH _gridH;
_ctrlGridBg ctrlCommit 0;


// create the "row"-images, inside the given _ctrlGrid
for "_pY" from 0 to (_gridRows-1)do
{
	// use its Y Coord as IDC
	private _idc = _pY;
	// add it to the "inventory"-area
	private _ctrl = _disp ctrlCreate ["tile_base",_idc,_ctrlGrid];
	_ctrl ctrlSetposition [0,(_tileH*_pY),_gridW,_tileH];
	_ctrl ctrlCommit 0;
};

localNamespace setVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrid)], _gridSize];
diag_log ["DEBUG: ui_inv_grid_create: size: ", localNamespace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrlGrid)],[-1,-1]]];