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

params ["_zombie"];

private _nextAttackTime = _zombie getVariable ["vgm_l_zombie_nextAttackAvailableTime", 0];

_nextAttackTime < time && !(_zombie getVariable ["vgm_l_zombie_attacking", false]) && { alive _zombie && lifeState _zombie in ["HEALTHY", "INJURED"] }
