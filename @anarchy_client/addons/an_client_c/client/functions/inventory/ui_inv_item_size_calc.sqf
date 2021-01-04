/*
	Calculate the width and height of an Item, depending on the size of the given invGrid control W/H (oh god, what a description...)
*/

private _DEBUGON = false;

params["_itemSize","_ctrlInvGrid"];

private _ctrlIDC = str(ctrlIDC _ctrlInvGrid);
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: _ctrlIDC    : ", _ctrlIDC];};
private _invData = AN_data_inventory get "inventory" get _ctrlIDC;
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: _invData    : ", _invData];};

private _isSlot = _invData get "isSlot";
private _gridRows = _invData get "inv_rows";
private _gridCols = _invData get "inv_cols";

if(_gridRows < 0)exitWith{systemchat str ["ITEM_CREATE: GRID NOT SET!", _gridRows];};

(ctrlPosition _ctrlInvGrid)params["","","_gridW","_gridH"];
private _tileW = _gridW / _gridCols;
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: _tileW      : ", _tileW];};
private _tileH = _gridH / _gridRows;
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: _tileH      : ", _tileH];};

// Get the Size of the Item
_itemSize params ["_parentSizeY", "_parentSizeX"];
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: _itemSize   : ", _itemSize];};

private _canFlip = if(_parentSizeY == _parentSizeX)then{0}else{1};
if((_canFlip == 0) && !an_inv_move_placeHorizontal)then{an_inv_move_placeHorizontal = true};

// if it's a Slot, fill the whole "grid" with the Icon.
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: _isSlot     : ", _isSlot];};
if(_isSlot == 1)exitWith
{
	_parentSizeY = _gridRows;
	_parentSizeX = _gridCols;
	//get width and height of selected icon
	private _pW = if(an_inv_move_placeHorizontal)then{_gridW}else{_gridH};
	private _pH = if(an_inv_move_placeHorizontal)then{_gridH}else{_gridW};
	if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: [_pW,_pH]   : ", [_pW,_pH]];};
	
	//return:
	[_pW, _pH]
};

//get width and height of selected icon
private _pW = if(an_inv_move_placeHorizontal)then{_tileW*_parentSizeX}else{_tileH*_parentSizeY};
private _pH = if(an_inv_move_placeHorizontal)then{_tileH*_parentSizeY}else{_tileW*_parentSizeX};
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_SIZE_CALC: [_pW,_pH]   : ", [_pW,_pH]];};

//return:
[_pW, _pH]