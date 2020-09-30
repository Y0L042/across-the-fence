/*
	control	-	control which has the grid in it
	[4,8]	-	grid size [rows, colums]
	[2,1]	-	item size [rows, colums]
*/

params["_ctrl", ["_grid_size",[],[[]]], ["_item_pos",[],[[]]]];

if(_item_pos isEqualTo [])exitWith{private _text = "ERROR: ui_inv_grid_gridToPos: NO POS FOUND"; systemchat _text; diag_log _text;};
_item_pos params ["_item_pos_y","_item_pos_x"];

//get the width and height of the passed control
(ctrlPosition _ctrl) params["","","_ctrl_w","_ctrl_h"];

_grid_size params ["_grid_y","_grid_x"];
//calc the width and height of each slot in the control
private _grid_w_tile = _ctrl_w / _grid_x;
private _grid_h_tile = _ctrl_h / _grid_y;

// calc the pos for given grid position (by adding little offset, we can be sure to find the correct one!):
_item_gridPos_y = (_grid_w_tile * _item_pos_x) + 0.001;
_item_gridPos_x = (_grid_h_tile * _item_pos_y) + 0.001;
diag_log ["_item_pos: ", _item_pos, "_item_gridPos: ", [_item_gridPos_y, _item_gridPos_x]];

//return the "UI pos" in the grid
[_item_gridPos_y, _item_gridPos_x]