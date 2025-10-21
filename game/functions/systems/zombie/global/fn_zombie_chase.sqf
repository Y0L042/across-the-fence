/*
    File: fn_zombie_chase.sqf
    Author:
    Date: 2025-10-20
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

if (time < _zombie getVariable ["vgm_l_zombie_chaseNextTick", 0]) exitWith {};

private _chaseTarget = _zombie getVariable ["vgm_l_zombie_chaseTarget", objNull];

if !([_zombie, _chaseTarget] call vgm_g_fnc_zombie_isValidTarget) exitWith {};

private _delay = linearConversion [10, 30, _zombie distance2D _chaseTarget, 0.1, 1];

_zombie setVariable ["vgm_l_zombie_chaseNextTick", time + _delay];

if (_zombie getVariable ["vgm_l_zombie_chaseNextRepath", 0] < time) then {
    _zombie doMove getPosATL _chaseTarget;
    _zombie setVariable ["vgm_l_zombie_chaseNextRepath", time + _delay];
};

// TODO - Victim change
// TODO - Sounds
// TODO - Consider moving to last seen position
