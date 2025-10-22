/*
    File: fn_zombie_makeNoise.sqf
    Author:
    Date: 2025-10-22
    Last Update: 2025-10-22
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

params ["_zombie", "_soundFile", "_volume"];

// TODO - Switch to say3D, but CfgSounds needs all off Ryan's sounds re-adding with the right volume...
playSound3D [_soundFile, _zombie, false, getPosASL _zombie, 1, 1, 100]


