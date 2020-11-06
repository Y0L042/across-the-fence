/*
    File: loot_inv_request.sqf
    Author: Dscha and Spoffy
    Date: 2020-08-28
    Last Update: 2020-11-06
    Public: No
    
    Description:
        Sends a request for a crate's inventory to the Arma server
    
    Parameter(s):
		None
    
    Returns:
		None
    
    Example(s):
		[]	call an_c_fnc_loot_inv_request
*/

private _target = cursorObject;

if (player distance _target > 5) exitWith {systemChat "DEBUG MSG: LOOT_INV_REQUEST: Too far away.";};
if !(_target getVariable ["an_c_looting_is_crate", false]) exitWith {systemChat "DEBUG MSG: LOOT_INV_REQUEST: Target is not a crate.";};

[
	'loot_request_crate_inventory', 
	//Grab building and index
	[_target getVariable "an_c_looting_building", _target getVariable "an_c_looting_index"]
] call para_c_fnc_call_on_server;
