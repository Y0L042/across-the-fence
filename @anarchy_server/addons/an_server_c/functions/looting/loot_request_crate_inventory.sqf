/*
	File: fn_loot_request_crate_inventory.sqf
	Author: Spoffy, Dscha
	Date: 2020-11-06
	Last Update: 2020-11-14
	Public: No

	Description:
		Code to do loot container request RE from client

	Parameter(s):
		None

	Returns:
		Nothing

	Example(s):
		[_object, 0] call AN_s_fnc_loot_request_crate_inventory;
		[_object, 0, _player] call AN_s_fnc_loot_request_crate_inventory;
*/
params[
		 ["_building",ObjNull,[ObjNull]]
		,["_index",0,[0]]
	];

_openInv = if(count(_this) < 3)then{1}else{0};	// DEV - Will be used for "a silent update" of the player Inventory - not triggering the "open Inventory" stuff
_player = if(_openInv == 1)then{_player}else{_this#2};

if (isNull _building) exitWith
{
	private _message = format ["Anarchy Error: Building not found - _this: %1", _this];
	diag_log _message;
	[_message] remoteExecCall ["systemChat", _player];
	
	// return
	[false,""]
};

private _cratePos = getPosATL _building;
private _isDroppedCrate = typeOf _building in ["Land_Ammobox_rounds_F"];
private _isLootCrate = if(_building isEqualTo _player || _isDroppedCrate )then{0}else{1};

if(_isLootCrate > 0)then
{
	//This must match the client, as it needs to generate the exact same seed.
	private _posSeed = [_cratePos] call an_g_fnc_loot_position_to_seed;
	private _crateSeed = _posSeed + _index;
	[format ["DEBUG: Looting crate with seed %1", _crateSeed]] remoteExec ["systemChat", _player];
	
	private _isValid = _crateSeed random 1 < an_g_looting_crate_probability;
	if !(_isValid) exitWith
	{
		private _message = format ["Anarchy Error: Bad crate requested, crate would not have spawned - Building: %1, Index: %2, Pos: %3", _building, _index, getPosATL _building];
		diag_log _message;
		[_message] remoteExec ["systemChat", _player];
	};

	_cratePos = (_building buildingPos _index);

	if (_player distance _cratePos > 5) exitWith 
	{
		private _message = format ["Anarchy error: Player %1 attempted to open crate from too far away: %2, %3", _player, _building buildingPos _index, getPosATL _player];
		diag_log _message;
		[_message] remoteExecCall ["systemChat", _player];
	};
};

// In case the player opens the Inventory, create a "droppedCrate" at this position.
// Will only creates the new droppedCrate, when a player puts something into it (triggerd on the client)
if(_isLootCrate == 0 || _isDroppedCrate)then
{
	_lootType = "type_generic";
	_minLootQuantity = 0;
	[_player, _cratePos] call an_s_fnc_loot_last_pos_set;
};

private _playerID = getPlayerUID _player;
//TODO - Make this based on map location.
private _lootType =	selectRandom ["type_generic", "type_military", "type_residential", "type_medical"];
private _crateId = [_cratePos] call an_g_fnc_loot_generate_crate_id;
private _minLootQuantity = round(random[1,3.5,6]); // DEV SETTINGS!
private _normalizedPosition = _cratePos apply {floor _x};

diag_log [":::: CRATE_LOOT_REQUEST: DATA:", ["call_function", ["crate_data_get", [_playerID, _normalizedPosition, _crateId, _lootType, _isLootCrate, _minLootQuantity]]]];
/*
	0 - STR - playerID
	1 - ARRAY - pos of crate
	2 - STR - global seed
	3 - STR - Type of loot to spawn
	4 - INT - Indicator (for the Backend) if it is a Loot-crate or not (1 = fill with loot | 0 = add nothing) - "1" also overrides a given gridSize!
	5 - INT - Optional Argument: set this, to override the standard value of min. "2" items bein created (Result can still be higher, depending on the Players "scavenging"-skill)
*/

["crate_data_get", [_playerID, _normalizedPosition, _crateId, _lootType, _isLootCrate, _minLootQuantity]] call AN_G_fnc_msg_send;

// return
[true, _crateId]
