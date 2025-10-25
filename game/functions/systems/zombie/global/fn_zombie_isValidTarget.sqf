/*
    File: fn_zombie_isValidTarget.sqf
    Author:
    Date: 2025-10-20
    Last Update: 2025-10-25
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

params ["_zombie", "_possibleTarget"];

private _aggroRange = _zombie getVariable "vgm_l_zombie_aggroRange";

// Start with `alive` check as it filters out objNull early
alive _possibleTarget && {
       (_possibleTarget distance _zombie < _aggroRange)
    && _possibleTarget getUnitTrait "camouflageCoef" > 0
    && !(_possibleTarget getVariable ["vgm_g_zombie_isZombie", false])
    && { [_zombie, _possibleTarget, _aggroRange] call vgm_g_fnc_zombie_canSee }
}
