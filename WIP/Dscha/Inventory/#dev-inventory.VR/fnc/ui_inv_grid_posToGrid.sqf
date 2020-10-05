/*
	get grid Position ([0,0]/[10,5]/etc) from the mousePos of the given gridCtrl
	!! WARNING !!
	Can return negative or "out of bounds" values!!
	Needs counterchecking the result for a "[-1,-1]" return (out of bounds), after executing this function!
	
*/

// ------------ CHECKED
params["_ctrl","_mPos_x","_mPos_y","_grid_y"];

(ctrlPosition _ctrl) params["_x","_y","_w","_h"];
private _mP_x = _mPos_x - _x;	//get Pos X, relative to X of ctrl
private _t_w = _w / 8;			//get tileSize Width
private _mP_y = _mPos_y - _y;	//get Pos Y, relative to Y of ctrl
private _t_h = _h / _grid_y;	//get tileSize Height

//calc the gridPos
private _t_row = floor(_mP_y / _t_h);
private _t_col = floor(_mP_x / _t_w);

//Check if within existing/given grid
private _inGrid = [_t_row,_t_col,_grid_y] call an_fnc_ui_inv_grid_isPosIn;
private _ret = [-1,-1];
if(_inGrid)then{_ret = [_t_row, _t_col]};

_ret
