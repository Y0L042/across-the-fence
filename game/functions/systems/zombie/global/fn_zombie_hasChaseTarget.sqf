/*
    File: fn_zombie_hasChaseTarget.sqf
    Author:
    Date: 2025-10-20
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

[_zombie, _zombie getVariable ["vgm_l_zombie_chaseTarget", objNull]] call vgm_g_fnc_zombie_isValidTarget
