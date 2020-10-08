

params["_ctrl_grid","_grid_usedSlots","_item_tiles_used"];
{
	_grid_usedSlots pushbackUnique _x;
}forEach _item_tiles_used;

[(ctrlIDC _ctrl_grid), _grid_usedSlots] call an_fnc_ui_inv_grid_tiles_used_set;
