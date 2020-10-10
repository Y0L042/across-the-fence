/*
	Recursive function, to find free slots, for the item to move to
	
	Returns empty array, if no free slots were found.
*/

params["_row_max", "_col_max", "_item_slot_usage","_grid_usedSlots", ["_row",0,[0]], ["_col",0,[0]]];
	
private _start = [_row, _col];
// Check if the 1st slot is taken:
if!(_start in _grid_usedSlots)then
{
	private _allFree = true;
	// 1st slot was free, let's check if the other slots are also:
	private _tmp_slots = [];
	{
		_var = _start vectorAdd _x;
		_var deleteAt 2;
		if(_var in _grid_usedSlots)exitWith{_allFree = false;};
		_tmp_slots pushback _var;
	}forEach _item_slot_usage;
	if(_allFree)then
	{
		// update _ret, so it will be updated in the other "instances" of this recursive function and will return THIS value!
		_ret = +_tmp_slots;
	};
};
// ret == empty array == No free slot found. So let's dig deeper (recursion happening, yeehhhaaaa )
if(_ret isEqualTo [])then
{
	_col = _col + 1;
	if(_col > _col_max)then
	{
		_row = _row + 1;
		_col = 0;
	};
	if(_row > _row_max)exitWith{_ret = []; diag_log "MAX ROW REACHED";};
	[_row_max, _col_max, _item_slot_usage, _grid_usedSlots, _row, _col] call an_fnc_ui_inv_item_slots_find_free;
};
_ret
