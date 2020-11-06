/*
	File: fn_loot_request_crate_inventory.sqf
	Author: Aaron Clark <vbawol>
	Date: 2020-07-20
	Last Update: 2020-09-02
	Public: No

	Description:
		Code to do loot container request RE from client

	Parameter(s):
		None

	Returns:
		Nothing

	Example(s):
		call AN_s_fnc_loot_request_crate_inventory;
*/
params ["_building", "_index"];

if (isNull _building) exitWith {};

//This must match the client, as it needs to generate the exact same seed.
private _posSeed = [getPos _building] call an_g_fnc_loot_position_to_seed;
private _crateSeed = _posSeed + _index;
[format ["Looting crate with seed %1", _crateSeed]] remoteExec ["systemChat", _player];

private _isValid = _crateSeed random 1 < an_g_looting_crate_probability;

if !(_isValid) exitWith 
{
	private _message = format ["Anarchy Error: Bad crate requested, crate would not have spawned - Building: %1, Index: %2, Pos: %3", _building, _index, getPos _building];
	diag_log _message;
	[_message] remoteExec ["systemChat", _player];
};

private _cratePos = (_building buildingPos _index);

if (_player distance _cratePos > 5) exitWith 
{
	private _message = format ["Anarchy error: Player %1 attempted to open crate from too far away: %2, %3", _player, _building buildingPos _index, getPos _player];
	diag_log _message;
	[_message] remoteExec ["systemChat", _player];
};

private _playerID = getPlayerUID _player;
//TODO - Make this based on map location.
private _lootType =	selectRandom ["type_generic", "type_military", "type_residential", "type_medical"];
private _crateId = [_cratePos] call an_g_fnc_loot_generate_crate_id;
private _isLootCrate = 1;
private _minLootQuantity = floor random [1,2,6];
private _normalizedPosition = _cratePos apply {floor _x};

diag_log [":::: CRATE_LOOT_REQUEST: DATA:", ["call_function", ["crate_data_get", [_playerID, _normalizedPosition, _crateId, _lootType]]]];

/*
	0 - STR - playerID
	1 - ARRAY - pos of crate
	2 - STR - global seed
	3 - STR - Type of loot to spawn
	4 - INT - Indicator (for the Backend) if it is a Loot-crate or not (1 = fill with loot | 0 = add nothing) - "1" also overrides a given gridSize!
	5 - INT - Optional Argument: set this, to override the standard value of min. "2" items bein created (Result can still be higher, depending on the Players "scavenging"-skill)
*/

private _lootAmount = 1;
// DEV OVERRIDE SETTINGS:
private _lootAmount = round(random[1,3.5,6]); // DEV SETTINGS:
["crate_data_get", [_playerID, _normalizedPosition, _crateId, _lootType, _isLootCrate, _lootAmount]] call AN_G_fnc_msg_send;