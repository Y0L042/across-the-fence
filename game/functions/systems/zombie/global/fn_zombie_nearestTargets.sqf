/*
    File: fn_zombie_nearestTarget.sqf
    Author:
    Date: 2025-10-19
    Last Update: 2025-10-20
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

// TODO - Add caching to speed this up?

private _targetsWithDist =
    (_zombie targets [true, _zombie getVariable "vgm_l_zombie_aggroRange"])
    select { [_zombie, _x] call vgm_g_fnc_zombie_isValidTarget }
    apply { [_zombie distance2D _x, _x] };

_targetsWithDist sort true;

_targetsWithDist apply {_x # 1}



