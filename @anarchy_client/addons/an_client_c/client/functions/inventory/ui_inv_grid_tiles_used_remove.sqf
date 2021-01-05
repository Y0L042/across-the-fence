
/*
	Remove the passed used tiles from the SubInventory.
	
	Note: Might need to be rechecked later, no performance check/comparsions done (Dscha: 05.01.2021)
*/

params["_subInvID","_removeTiles"];
private _invSlotsUsed = [_subInvID] call an_c_fnc_ui_inv_grid_tiles_used_get;
private _index = 0;
{
	_slot = _x;
	_index = _invSlotsUsed findIf{_x isEqualTo _slot};
	if(_index >= 0)then{_invSlotsUsed deleteAt _index};
}forEach _removeTiles;
// _invSlotsUsed is referenced! So it is instantly updating the hashMap data! Nothing else needs to be done here.