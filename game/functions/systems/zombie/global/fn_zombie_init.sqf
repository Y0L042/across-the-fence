/*
    File: fn_zombie_init.sqf
    Author:
    Date: 2025-10-19
    Last Update: 2025-10-24
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

params ["_zombie", ["_runBrain", true]];

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
_zombie setDamage vgm_g_zombie_initialDamage;

[_zombie, selectRandom RZ_FaceArray] remoteExecCall ["setFace", 0];
[_zombie, "NoVoice"] remoteExecCall ["setSpeaker", 0];
[_zombie, "safe"] remoteExecCall ["setMimic", 0];

_zombie setVariable ["vgm_l_zombie_aggroRange", 30];
_zombie setVariable ["vgm_l_zombie_idleSoundWait", time + 5 + random 20];
_zombie setVariable ["vgm_l_zombie_loiterTimeout", time + 5 + random 15];
_zombie setVariable ["vgm_l_zombie_attackDelay", 2];
_zombie setVariable ["vgm_l_zombie_isScreamer", random 1 < vgm_g_zombie_screamerChance];

_zombie setVariable ["vgm_g_zombie_isZombie", true, true];

private _zombieClassName = typeOf _zombie;

private _zombieType = switch (true) do {
    case ("walker" in _zombieClassName): { "walker" };
    case ("slow" in _zombieClassName): { "slow" };
    case ("medium" in _zombieClassName): { "medium" };
    case ("fast" in _zombieClassName): { "fast" };
    case ("player" in _zombieClassName): { "player" };
    case ("crawler" in _zombieClassName): { "crawler" };
    case ("spider" in _zombieClassName): { "spider" };
    default { "unknown" };
};

_zombie setVariable ["vgm_g_zombie_type", _zombieType, true];

_zombie setAnimSpeedCoef (vgm_g_zombie_animCoefs getOrDefault [_zombieType, 1]);

_zombie addEventHandler ["AnimDone", {
    params ["_unit", "_anim"];
    // Case insensitive match
    if (_anim != "AwopPercMstpSgthWnonDnon_throw") exitWith {};

    [_unit] call vgm_g_fnc_zombie_onAttackEnd;
}];


// Note: None of the code in this section will work with agents

private _group = group _zombie;
private _eventGroup = _group getVariable ["vgm_g_missionId", vgm_g_dangerReport_defaultLocEventGroup];

private _locEventHandlers = [
    _eventGroup,
    _group,
    [ "player_explosion", "player_gunshots_aggregate", "player_flare", "player_distraction", "zombie_alert" ],
    [ _group, _zombie ],
    {
        params ["_pos", "_type", "_listener", "_eventData", "_args"];
        _args params ["_group", "_zombie"];

        _zombie getVariable ["vgm_l_zombie_lastAlertEvent", ["none", [-9999, -9999, 0], 0]]
            params ["_lastEventType", "_lastEventPos", "_lastEventTime"];

        private _currentEvent = [_type, _pos, time];
        _currentEvent params ["_eventType", "_eventPos", "_eventTime"];

        private _lastEventValue =
            (vgm_g_zombie_alertEventPriorities getOrDefault [_lastEventType, 1])
            * (
                linearConversion [0, 200, (getPosATL _zombie distance2D _lastEventPos), 1, 0, true]
                + linearConversion [0, 120, (time - _lastEventTime), 1, 0, true]
            );

        private _currentEventValue =
            (vgm_g_zombie_alertEventPriorities getOrDefault [_eventType, 1])
            * (
                linearConversion [0, 200, (getPosATL _zombie distance2D _eventPos), 1, 0, true]
                + 1
            );

        if (_currentEventValue > _lastEventValue) then {
            // Last event should be updated when nextAlertEvent is processed.
            _zombie setVariable ["vgm_l_zombie_nextAlertEvent", _currentEvent];
        };
    }
] call vgm_g_fnc_locEvents_onNearbyEvent;

_zombie setVariable ["vgm_l_zombie_locEventHandlers", _locEventHandlers];

private _handleDamageEH = _zombie addEventHandler ["HandleDamage", {
	params ["_zombie", "_selection", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

    if (!_directHit || isNull _instigator) exitWith { nil };

    private _lastDamageAlertDetails = _zombie getVariable ["vgm_l_zombie_lastDamageAlertDetails", [-9999, [-9999, -9999, 0], objNull]];

    _lastDamageAlertDetails params ["_lastAlertTime", "_lastAlertPos", "_lastAlertInstigator"];

    if (getPosATL _zombie distance2D getPosATL _instigator < getPosATL _zombie distance2D _lastAlertPos) then {
        _zombie setVariable ["vgm_l_zombie_lastDamageAlertDetails", [time, getPosATL _instigator, _instigator]];
        _zombie setVariable ["vgm_l_zombie_nextAlertEvent", ["hit", getPosATL _instigator, time]];
    };

    nil
}];

_zombie setVariable ["vgm_l_zombie_handleDamageEH", _handleDamageEH];

if (_runBrain) then {
    [_zombie] execFSM "functions\systems\zombie\zombie_brain.fsm";
};
