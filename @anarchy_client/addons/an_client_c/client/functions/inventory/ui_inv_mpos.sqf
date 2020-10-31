
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

// _btn used by mPos_check_inInv
params ["_ctrl_grid", "_btn", "_mPos", ["_btn_shift",false,[false]], ["_btn_ctrl",false,[false]], ["_btn_alt",false,[false]]];

_mPos params ["_mPos_x", "_mPos_y"];

private _grid_idc = ctrlIDC _ctrl_grid;
_gridSize = localNamespace getVariable [format["an_inv_grid_size_%1",_grid_idc],[-1,-1]];
_gridSize params ["_gridRows","_gridCols"];
if(_gridRows isEqualto [-1,-1])exitWith
{
	diag_log ["ERROR: UI_INV_MPOS: GRID NOT SET!", _grid_idc, [_gridRows]];
};


//Check if given pos is valid in the Grid. If so -> Return [y,x] pos in Grid
([_ctrl_grid,_mPos_x,_mPos_y,_gridRows] call an_c_fnc_ui_inv_grid_posToGrid) params["_tile_row","_tile_col"];
if([_tile_row,_tile_col] isEqualto [-1,-1])exitWith{/* DEV */ systemchat str["gridPos - out of Bounds",[_tile_row, _tile_col]];};


//Check if DragAndDrop is active. If so -> a suitable pos was found, so we can delete the temp Item, "attached" to the Mouse
if(an_ui_inv_grabActive)then{ an_ui_inv_grabActive = false; };


//////////////////////////////////////////////
private _item_class = [] call an_c_fnc_ui_inv_item_active_class_get;
private _parentData = [_item_class] call an_c_fnc_ui_inv_item_data_parent_get;
// diag_log ["DEBUG: UI_INV_MPOS: _parentData   :", _parentData];
private _parentSize = ENTRY_GET("size",_parentData);
// diag_log ["DEBUG: UI_INV_MPOS: _parentSize   :", _parentSize];
private _parentSlot = ENTRY_GET("slot",_parentData);
diag_log ["DEBUG: UI_INV_MPOS: _parentSlot   :", _parentSlot];


// Check if targeted Grid is a Slot and it is allowed to be placed in there
_slotID = _ctrl_grid getVariable ["slotID", 0];
systemchat str [_parentSlot, _slotID];

_slotValidCheck = true;
// Check if it's 
if(_slotID > 0)then
{
	systemchat "IS SLOT: TRUE";
	if(_parentSlot != _slotID)exitWith{_slotValidCheck = false;};
	systemchat "SLOT CHECK PASSED - Reseting ROW/COL";
	// if -> reset the Row/Col to [0,0]
	_tile_row = 0;
	_tile_col = 0;
}
else
{
	systemchat "IS SLOT: FALSE";
};
if(!_slotValidCheck)exitWith{systemchat "Can't be placed in that Slot";};

private _item_slot_usage = [_parentSize] call an_c_fnc_ui_inv_item_slots_usage_get;

//_tiles_used == taken positions in Grid, needed to free up the needed Slots later
private _offset_pos = [[_tile_row, _tile_col]];	//store first Pos (needed, since the offset will determined from this position)
{
	_x params["_pos_row","_pos_col"];
	if(an_inv_move_placeHorizontal)then
	{
		_offset_pos pushbackUnique [ (_tile_row + _pos_row), (_tile_col - (_pos_col*-1)) ];
	}else{
		_offset_pos pushbackUnique [ (_tile_row + _pos_col), (_tile_col + _pos_row) ];
	};
}forEach _item_slot_usage;


//Check if all tiles are free
//get used slots from grid
private _grid_tiles_used = [_grid_idc] call an_c_fnc_ui_inv_grid_tiles_used_get;
// diag_log["------- _grid_tiles_used: ",_grid_tiles_used];

// Check if tiles in the targeted Grid are free. If not -> Return empty Array and trigger a "re-add" to the old position
// if free -> Return the used Tiles
private _item_tile_usage = [_ctrl_grid,_gridRows,_offset_pos,_grid_tiles_used] call an_c_fnc_ui_inv_grid_check_freeTiles;
// diag_log["------- _item_tile_usage: ",_item_tile_usage];

// Check if its a failed attemp
if!(_item_tile_usage isEqualto [])then
{
	// add all tiles to the "blocked tiles"-array and store it in the Grid-parent itself
	[_ctrl_grid,_grid_tiles_used,_item_tile_usage] call an_c_fnc_ui_inv_grid_tiles_used_update;
	
	// get the grid pos of the first entry (TopLeft Slot)
	([_ctrl_grid, _gridRows, _item_tile_usage#0] call an_c_fnc_ui_inv_grid_gridToPos)params["_item_gridPos_row", "_item_gridPos_col"];
	
	// add the Item to the passed position
	[_ctrl_grid,_item_gridPos_row,_item_gridPos_col,_item_class,_offset_pos] call an_c_fnc_ui_inv_item_create;
	
}
else
{
	// if failed attemp -> readd the Item and its used slots in its previously used grid
	private _ctrl = uinamespace getVariable ["an_ctrl_active",controlNull];
	if(isNull _ctrl)exitWith{};
	
	private _data_prev = _ctrl getVariable ["item_data_prev",[]];
	if(_data_prev isEqualto [])exitWith{};
	
	// Get the previous data
	_data_prev params ["_ctrl_parent_prev","_p_x","_p_y","_item_class","_item_usedSlots_prev","_pos_data"];
	
	private _grid_tiles_used_cur = [(ctrlIDC _ctrl_parent_prev)] call an_c_fnc_ui_inv_grid_tiles_used_get;
	
	// add all tiles to the "blocked tiles"-array and store it in the Grid-parent itself
	[_ctrl_parent_prev,_grid_tiles_used_cur,_item_usedSlots_prev] call an_c_fnc_ui_inv_grid_tiles_used_update;
	
	// create it again
	_data_prev call an_c_fnc_ui_inv_item_create;
};


