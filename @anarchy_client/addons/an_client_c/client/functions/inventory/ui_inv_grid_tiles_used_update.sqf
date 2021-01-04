

params["_ctrlGrid","_grid_usedSlots","_item_tiles_used"];

{
	_grid_usedSlots pushbackUnique _x;	
}forEach _item_tiles_used;
// !!
// _grid_usedSlots is referenced! So it is instantly updated in the hashMap
// !!