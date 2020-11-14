/*
    File: eh_EntityRespawned.sqf
    Author: Aaron Clark <vbawol>, Dscha
    Date: 2020-04-12
    Last Update: 2020-11-14
    Public: No

    Description:
		Entity respawned event handler, used to reapply unit loadout after death.

    Parameter(s):
		_entity - respawned entity [OBJECT]
		_corpse - corpse/wreck [OBJECT]

    Returns: nothing

    Example(s):
		Not called directly.
*/

params
[
	"_entity",
	"_corpse"
];
// respawn player with same loadout as before death

["EntityRespawned mEH: %1", _this] call BIS_fnc_logFormat;


// DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV 

an_s_fnc_EH_respawned =
{
	params ["_entity", "_corpse"];
	
	["player_respawned", [(getPlayerUID _entity)]] call AN_G_fnc_msg_send;
};

_this call an_s_fnc_EH_respawned;

// DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV 

