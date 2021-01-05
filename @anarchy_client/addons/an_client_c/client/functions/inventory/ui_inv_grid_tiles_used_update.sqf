
/*
	NOTE:
	!!
		_grid_usedSlots is referenced! So it is instantly updated in the hashMap
	!!
*/

params["_gridUsedSlots","_itemTileUsage"];

{
	_gridUsedSlots pushbackUnique _x;
}forEach _itemTileUsage;