#include "..\..\medical\client\script_component.inc"

/*
    File: fn_zombie_onAttackEnd.sqf
    Author:
    Date: 2025-10-21
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

private _target = _zombie getVariable ["vgm_l_zombie_attackTarget", objNull];

_zombie setVariable ["vgm_l_zombie_attacking", false];
_zombie setVariable ["vgm_l_zombie_attackTarget", objNull];

// Ensure zombie can still attack the target at the end of the animation.
if !([_zombie, _target] call vgm_g_fnc_zombie_canAttackTarget) exitWith {};

// TODO - Set up sounds properly
//_hitSound = selectRandom ([_zombie,"hit"] call RZ_fnc_zombie_getZombieSoundArray);
private _hitSound = selectRandom RZ_ZombieHitArray;
playSound3D [_hitSound, _target, false, getPosASL _target, 1, pitch _zombie];

private _bodyPartHit = selectRandomWeighted [BODY_PART_HEAD, 1, BODY_PART_ARMS, 5, BODY_PART_TORSO, 2.5, BODY_PART_LEGS, 2.5];
private _damageLevel = selectRandomWeighted [
    // 80% of the time, do only 1 damage.
    1, 4,
    // 20% of the time, hit harder
    2, 1
];

[_target, _bodyPartHit, _damageLevel] remoteExecCall ["vgm_c_fnc_medical_addWound", _target];

// TODO - Consider resurrection and infection

_scream = selectRandom RZ_HumanScreamArray;
[_target, _scream] remoteExecCall ["say3D"];

private _zombieDirVec = vectorDir _zombie vectorAdd [0, 0, 0.1];
private _targetVelocity = velocity _target;

[_target, _targetVelocity vectorAdd (_zombieDirVec vectorMultiply 5)] remoteExecCall ["setVelocity", _target];
