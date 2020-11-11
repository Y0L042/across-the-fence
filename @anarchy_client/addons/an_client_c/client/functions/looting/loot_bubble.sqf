/*
	File: fn_loot_bubble.sqf
	Author: Spoffy and Aaron Clark <vbawol>
	Date: 2020-07-20
	Last Update: 2020-09-02
	Public: No

	Description:
		Creates loot containers in the local area when called.

	Parameter(s):
		None

	Returns:
		Nothing

	Example(s):
		call AN_C_fnc_loot_bubble;
*/

if (isNil "an_c_looting_spawned_buildings") then {
	an_c_looting_spawned_buildings = [];
	an_c_looting_spawned_crates = [];
	an_c_looting_last_player_pos = [0,0,0];
	an_c_looting_range = 200;
	an_c_looting_min_distance_refresh =	100;
	player addAction [
		"ASC: get crateData", 
		{[cursorObject] call AN_C_fnc_loot_inv_request;}, 
		[], 
		1.5, 
		true, 
		true, 
		"",
		"cursorObject getVariable ['an_c_looting_is_crate', false]", 
		5, 
		false
	];
};

private _playerPos = getPos player;
if (   _playerPos distance an_c_looting_last_player_pos < an_c_looting_min_distance_refresh
	|| vehicle player isKindOf "Air"
) exitWith {};

private _startTime = diag_frameNo;

an_c_looting_last_player_pos = _playerPos;

private _buildingsInRange = _playerPos nearObjects ["House", an_c_looting_range];
private _spawnBuildings = _buildingsInRange - an_c_looting_spawned_buildings;
an_c_looting_spawned_buildings = _buildingsInRange;

if (!isNil "debug_loot_bubble") then {
	systemChat format ["Spawning buildings: %1", count _spawnBuildings];
};

//Spawn in new buildings.
{
	private _building = _x;
	private _finalSeed = [getPos _building] call an_g_fnc_loot_position_to_seed;

	{
		private _chance = (_finalSeed + _forEachIndex) random 1;
		if (_chance < an_g_looting_crate_probability) then {
			private _crate = createSimpleObject ["Land_vn_object_trashcan_01", AGLtoASL _x, true];
			_crate setVariable ["an_c_looting_is_crate", true];
			_crate setVariable ["an_c_looting_building", _building];
			_crate setVariable ["an_c_looting_index", _forEachIndex];
			an_c_looting_spawned_crates pushBack _crate;
		};
	} forEach (_building buildingPos -1);

	an_c_looting_spawned_buildings pushBack _building;
} forEach _spawnBuildings;


//Despawn out of range crates.
private _cratesInRange = (an_c_looting_spawned_crates inAreaArray [_playerPos, an_c_looting_range, an_c_looting_range]);
private _despawnCrates = an_c_looting_spawned_crates - _cratesInRange;
{
	deleteVehicle _x;
} forEach _despawnCrates;

an_c_looting_spawned_crates = an_c_looting_spawned_crates select {!isNull _x};

if (!isNil "debug_loot_bubble") then {
	systemChat format ["Loot Bubble runtime: %1", diag_frameNo - _startTime];
};
