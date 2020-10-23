/*
    File: fn_factions_recruiter_join_faction.sqf
    Author: Spoffy
    Date: 2020-10-12
    Last Update: 2020-10-12
    Public: No
    
    Description:
        Attempts to join a player to a faction via a recruiter.
    
    Parameter(s):
        _recruiter - Recruiter to join using [OBJECT]

	Environment:
		_player - The player to join to the faction. [OBJECT]
    
    Returns:
        None
    
    Example(s):
		private _player = allPlayers select 0;
		[recruiters # 0] call an_s_fnc_factions_recruiter_join_faction
*/
params ["_recruiter"];

//Player or recruiter is invalid.
hint str _this;
private _side = _recruiter getVariable ["an_s_recruiter_side", sideUnknown];
if (!isPlayer _player || _side isEqualTo sideUnknown) exitWith {};
if (_player distance2D _recruiter > 10) then {diag_log format ["Anarchy: Warning: Player %1 attempted to join a recruiter, but was too far away.", name _player]};

[_player, _side] call an_s_fnc_factions_join_faction;

//This probably isn't the final mechanism we want to use for this, but for now, it works well enough.
_player setPos getMarkerPos (format ["an_respawn_%1_home_base", _side]);