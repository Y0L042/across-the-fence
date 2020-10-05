
// ------------ CHECKED
params["_ctrl_gridCur","_grid_size_row","_pos_toCheck","_tiles_toCheck"];
//ToDo: Reload previous tiles_usage
private _tile_list = [];
{
	_x params ["_row","_col"];
	private _gridPos = [_row,_col];
	//Check if pos is within grid
	if	(
				_col > (8-1)					// 8 == standard Width, "-1" not rly needed, but left in, in case of changing it (simply searching for 8, if needed)
			||	_col < 0
			||	_row > (_grid_size_row-1)		// Reminder: Index starts at 0, row count starts from 1
			||	_row < 0
			||	_gridPos in _tiles_toCheck		//if something is already placed there
		)exitWith{_tile_list = [];};
	
	_tile_list pushback _gridPos;
}forEach _pos_toCheck;
_tile_list sort true;
_tile_list