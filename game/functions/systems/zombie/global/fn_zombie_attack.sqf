/*
    File: fnc_canAttack.sqf
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

params ["_zombie", "_target"];

_zombie setVariable ["vgm_l_zombie_attacking", true];
_zombie setVariable ["vgm_l_zombie_attackTarget", _target];
_zombie setVariable ["vgm_l_zombie_nextAttackAvailableTime", time + (_zombie getVariable "vgm_l_zombie_attackDelay")];

_zombie setDir (_zombie getDir _target);

_zombie doWatch _target;
// Performs the attack - damage happens in onAttackEnd.
_zombie switchMove "AwopPercMstpSgthWnonDnon_throw";

// TODO - Set up sounds properly
private _attackSound = selectRandom RZ_NormalZombieAttackArray; //selectRandom ([_zombie,"attack"] call RZ_fnc_zombie_getZombieSoundArray);
playSound3D [_attackSound, _zombie, false, getPosASL _zombie, 1, pitch _zombie];
