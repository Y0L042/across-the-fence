/*
	Recursive function, to find free slots, for the item to move to
	
	Returns empty array, if no free slots were found.
	
	!!!!! ATTENTION !!!!!
	_ret = []; <--- NEEDS TO BE DEFINED, BEFORE CALLING an_c_fnc_ui_inv_item_space_find_free_check!
*/

_ret = [];	// DO NOT "PRIVATE" THIS VAR (DEV)
private _slots_used = _this call an_c_fnc_ui_inv_item_space_find_free_check;
_ret
