
disableSerialization;
params ["_ctrl", "_btn", "_btn_shift", "_btn_ctrl", "_btn_alt"];
// "G"
if(_btn == 34)then
{
	private _dist_max = 2;
	if !(cursorObject getVariable ['an_c_looting_is_crate', false])then
	{
		private _crate = player;
		// Get the nearest lootcrates
		private _nearestLootCrate = an_c_looting_spawned_crates inAreaArray [getPos player, 2, 2];
		// If there are multiples close by -> select the closest one.
		private _nearestLootCrate_cnt = count(_nearestLootCrate);
		if(_nearestLootCrate_cnt > 0)then
		{
			if(_nearestLootCrate_cnt == 1)exitWith{_crate = _nearestLootCrate#0};
			private _dist = 2;
			{
				_distCheck = _x distance player;
				if(_distCheck < _dist)then{_dist = _distCheck; _crate = _x; };
			}forEach _nearestLootCrate;
		};
		// If there were crates close by, check again if something ostructs the line of sight (e.g: a Wall)
		if !(_crate isEqualTo player)then
		{
			private _LISW_check = lineIntersectsWith[eyePos player, getPosASL _crate]#0;
			// Reset back to the player, if something is in the way.
			if !(_LISW_check isEqualTo _crate)then
			{
				_crate = player;
			};
		};
		// finaly request the Inventory
		[_crate] call AN_C_fnc_loot_inv_request;
	}
	else
	{
		if(player distance cursorObject < _dist_max)then{ [cursorObject] call AN_C_fnc_loot_inv_request; };
	};
};