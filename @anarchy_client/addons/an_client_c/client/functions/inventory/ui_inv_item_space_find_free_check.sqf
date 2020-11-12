/*
	Recursive function, to find free slots, for the item to move to
	
	Returns empty array, if no free slots were found.
	
*/
private _DEBUGON = false;
params["_row_max", "_col_max", "_item_slot_usage","_grid_usedSlots", ["_row",0,[0]], ["_col",0,[0]]];

private _start = [_row, _col];
// Check if the 1st slot is taken:
if !(_start in _grid_usedSlots)then
{
	// 1st slot was free, let's check if the others are too:
	private _tmp_slots = [];
	{
		// Add the start-offset to the base item slot usage
		_slot = _start vectorAdd _x;
		_slot deleteAt 2;	// vectorAdd adds, when used with a 2D Vector, a third entry with 0 at the end... great...
		if(_slot in _grid_usedSlots)exitWith{_tmp_slots = [];};
		_tmp_slots pushback _slot;
	}forEach _item_slot_usage;
	// Check if we found enough free slots (== _tmp_slots wasn't reset to [] before)
	if !(_tmp_slots isEqualTo [])then
	{
		// update _ret, so it will be updated in the other "instances" of this recursive function and will return THIS value!
		_ret = +_tmp_slots;
	};
};
// ret == empty array == No free slot were found before. So let's dig deeper (recursion happening, yeehhhaaaa )
if(_ret isEqualTo [])then
{
	// try the next column
	_col = _col + 1;
	// Check if we reached the column limit. (no need to check the last column, if the Itemsize is larger than 1)
	if(_col > _col_max)then
	{
		// reset the Col back to 0 and set the next row
		_row = _row + 1;
		_col = 0;
	};
	// Check if we reached the last Row to check
	if(_DEBUGON)then{	diag_log ["_col: ", _col_max, _col," - _row: ", _row_max, _row];};
	
	if(_row > _row_max)exitWith{systemchat "ERROR: item_slots_find_free_check: (_row > _row_max)";};
	[_row_max, _col_max, _item_slot_usage, _grid_usedSlots, _row, _col] call an_c_fnc_ui_inv_item_space_find_free;
};

