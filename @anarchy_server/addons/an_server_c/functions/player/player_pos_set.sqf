/*
    File: player_pos_set.sqf
    Author: Dscha
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Sets the player to a specific position (world-coordinates!)

		Player pawn *must exist when this function is called*
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset = [
						 ["data_puid",123456]
						,["data_pos", [[0,0,0], 180, "stance"] ]
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

// get Pos and Dir
private _dataPos = ENTRY_GET("data_pos",_dataset);
_dataPos params["_pos","_dir",["_stance","",[""]]];

// switchMove is local, so must be executed on the Client...
// TODO: Check for "invalid" stances like "floating" etc
// _stance = ""; -> Unit is standing
[[_stance], {player switchMove (_this#0);}] remoteExecCall ["call", owner _player];

_player setDir _dir;

if(_pos isEqualTo [0,0,0])then
{
	_player setPos markerPos "new_player_spawn";
}
else
{
	_player setPosWorld _pos;
};


