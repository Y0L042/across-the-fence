/*
    File: loot_inv_request.sqf
    Author: Dscha and Spoffy
    Date: 2020-08-28
    Last Update: 2020-11-11
    Public: No
    
    Description:
        Sends a request for a crate's inventory to the Arma server
    
    Parameter(s):
		0: Object - Object to check
    
    Returns:
		None
    
    Example(s):
		[player] call an_c_fnc_loot_inv_request;
*/
// In case of no Object passed (e.g. addAction), select the Cursorobject
params[ ["_target", objNull, [objNull]] ];

if (isNull _target) exitWith {systemChat "DEBUG MSG: LOOT_INV_REQUEST: No Object selected.";};
if (player distance _target > 2) exitWith {systemChat "DEBUG MSG: LOOT_INV_REQUEST: Too far away.";};
private _isLootCrate = _target getVariable ["an_c_looting_is_crate", false];
private _isPlayer = _target isEqualTo player;
private _isDroppedCrate = typeOf _target in ["Land_Ammobox_rounds_F"];
if (
			!_isLootCrate
		&&	!_isPlayer
		&&	!_isDroppedCrate
	) exitWith {systemChat "DEBUG MSG: LOOT_INV_REQUEST: Target is not a crate OR a player.";};


// ToDo: Check: when to trigger the "create a new Crate"-stuff :think: when an Item is dropped? :think: ToDo for later...
// [ building, garrison pos index ]
// Request the crate Data (and determine if a lootcrate was requested, or if the player just openend his inventory)
// if (_target isEqualTo player) = True = _index will be ignored and a new empty "crate" will be created on the Client (and Backend)
if(_isLootCrate)then
{
	// If a lootcrate -> Gogogo
	[ "loot_request_crate_inventory" ,[ _target getVariable "an_c_looting_building" ,_target getVariable "an_c_looting_index"] ] call para_c_fnc_call_on_server;
}
else
{
	// Is it something, that another player dropped?
	if(_isDroppedCrate)then	{ [ "loot_request_crate_inventory" ,[ _target , 0] ] call para_c_fnc_call_on_server; }
	// Or did the player just openend his Inventory? (WIP - Creates a new "dropped crate"!)
	else					{ [ "loot_request_crate_inventory" ,[ player , 0] ] call para_c_fnc_call_on_server; };
};


