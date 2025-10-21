/*
    File: fn_zombie_init.sqf
    Author:
    Date: 2025-10-19
    Last Update: 2025-10-21
    Public: No

    Description:
        No description added yet.

    Parameter(s):
        N/A

    Returns:
        Something [BOOL]

    Example(s):
        [parameter] call vgm_X_fnc_component_myFunction
 */

params ["_zombie"];

{_zombie disableAI _x} forEach ["AIMINGERROR", "AUTOTARGET", "TARGET", "FSM", "AUTOCOMBAT", "COVER", "SUPPRESSION", "LIGHTS", "MINEDETECTION", "NVG", "RADIOPROTOCOL", "WEAPONAIM", "FIREWEAPON"];
_zombie setVariable ["BIS_fnc_animalBehaviour_disable", true];
_zombie setVariable ["BIS_enableRandomization", false];

removeAllAssignedItems _zombie;
removeAllItems _zombie;

_zombie setSkill 0;
_zombie addRating -1E4;
_zombie allowSprint true;
_zombie enableFatigue false;
_zombie enableStamina false;
_zombie setCombatMode "BLUE";
_zombie setBehaviour "CARELESS";
_zombie setUnitPos "UP";
_zombie allowFleeing 0;
_zombie setDamage 0.45;

[_zombie, selectRandom RZ_FaceArray] remoteExecCall ["setFace", 0];
[_zombie, "NoVoice"] remoteExecCall ["setSpeaker", 0];
[_zombie, "safe"] remoteExecCall ["setMimic", 0];

_zombie setVariable ["vgm_l_zombie_aggroRange", 30];
_zombie setVariable ["vgm_l_zombie_idleSoundWait", time + 5 + random 20];
_zombie setVariable ["vgm_l_zombie_loiterTimeout", time + 5 + random 15];
_zombie setVariable ["vgm_l_zombie_attackDelay", 2];

_zombie setVariable ["vgm_g_zombie_isZombie", true, true];

_zombie addEventHandler ["AnimDone", {
    params ["_unit", "_anim"];
    // Case insensitive match
    if (_anim != "AwopPercMstpSgthWnonDnon_throw") exitWith {};

    [_unit] call vgm_g_fnc_zombie_onAttackEnd;
}];

// TODO - Anim speed coef


