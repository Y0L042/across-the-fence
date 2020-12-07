/*
	Calculate the width and height of an Item, depending on the size of the given invGrid control W/H (oh god, what a description...)
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_parentData","_ctrlInvGrid"];

private _gridRows = _ctrlInvGrid getVariable ["rows", -1];
private _gridCols = _ctrlInvGrid getVariable ["cols", -1];
if(_gridRows < 0)exitWith{systemchat str ["ITEM_CREATE: GRID NOT SET!", _gridRows];};

(ctrlPosition _ctrlInvGrid)params["","","_gridW","_gridH"];
private _tileW = _gridW / _gridCols;
private _tileH = _gridH / _gridRows;

ENTRY_GET("size",_parentData) params ["_parentSizeY", "_parentSizeX"];
private _canFlip = if(_parentSizeY == _parentSizeX)then{0}else{1};
if((_canFlip == 0) && !an_inv_move_placeHorizontal)then{an_inv_move_placeHorizontal = true};
//get width and height of selected icon
private _pW = if(an_inv_move_placeHorizontal)then{_tileW*_parentSizeX}else{_tileH*_parentSizeY};
private _pH = if(an_inv_move_placeHorizontal)then{_tileH*_parentSizeY}else{_tileW*_parentSizeX};

//return:
[_pW, _pH]