/*
    File: player_health_set.sqf
    Author: Dscha
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Sets the Health of the given player.

		Player pawn *must exist when this function is called*
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset = [
						 ["data_puid",123456]
						,["data_health", 0.123 ]
					]
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];

private _playerUID = ENTRY_GET("data_puid",_dataset);
private _player = [_playerUID] call AN_S_fnc_player_get_by_puid;
if(isNull _player)exitWith{};

// set health:
private _data_health = ENTRY_GET("data_health",_dataset);
_player setDamage _data_health;

true