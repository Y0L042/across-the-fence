/*
	control	-	control which has the grid in it
	[4,8]	-	grid size [rows, colums]
	[2,1]	-	item size [rows, colums]
*/
private _DEBUGON = false;
params["_ctrl", ["_grid_rows",-1,[0]], ["_item_pos",[],[[]]]];

if(_item_pos isEqualTo [])exitWith{private _text = "ERROR: ui_inv_grid_gridToPos: NO POS FOUND"; systemchat _text; diag_log _text; []};
if(_grid_rows < 0)exitWith{diag_log "ERROR: GRIDTOPOS: _grid_rows < 0"; []};
_item_pos params ["_item_pos_row","_item_pos_col"];

//get the width and height of the passed Inventory
(ctrlPosition _ctrl) params["","","_ctrl_w","_ctrl_h"];

//calc the width and height of each slot in the control
private _invSizeCol = _ctrl getVariable ["an_sizeCol", 8];	// ToDo: an_sizeCol - Recheck if needed.
private _grid_w_tile = _ctrl_w / _invSizeCol;
private _grid_h_tile = _ctrl_h / _grid_rows;

// calc the pos for given grid position (by adding little offset, we can be sure to find the correct one!):
private _item_gridPos_row = (_grid_w_tile * _item_pos_col) + 0.001;
private _item_gridPos_col = (_grid_h_tile * _item_pos_row) + 0.001;
if(_DEBUGON)then{diag_log ["_item_pos: ", _item_pos, "_item_gridPos: ", [_item_gridPos_row, _item_gridPos_col]];};
if(_DEBUGON)then{systemchat str ["GridToPos: ", _item_gridPos_row, _item_gridPos_col];};

//return the "UI pos" in the grid
[_item_gridPos_row, _item_gridPos_col]