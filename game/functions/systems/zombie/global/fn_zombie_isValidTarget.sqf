/*
    File: fn_zombie_isValidTarget.sqf
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

params ["_zombie", "_possibleTarget"];

// Start with `alive` check as it filters out objNull early
alive _possibleTarget
    // TODO - Make valid targets range consider target movement speed
    && (_possibleTarget distance _zombie < (_zombie getVariable "vgm_l_zombie_aggroRange"))
    && _possibleTarget getUnitTrait "camouflageCoef" > 0
