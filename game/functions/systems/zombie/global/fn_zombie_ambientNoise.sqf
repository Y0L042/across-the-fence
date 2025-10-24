/*
    File: fn_zombie_ambientNoise.sqf
    Author:
    Date: 2025-10-24
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

params ["_zombie", "_soundType", "_delayRange"];

private _nextSounds = _zombie getVariable "vgm_l_zombie_nextSoundPossible";

if (time < _nextSounds getOrDefault [_soundType, 0]) exitWith {};

private _allSounds = _zombie getVariable "vgm_l_zombie_sounds";
private _sound = selectRandom (_allSounds getOrDefault [_soundType, []]);

if (isNil "_sound") exitWith {};

_nextSounds set [_soundType, time + ((_delayRange # 0) + random (_delayRange # 1))];
[_zombie, _sound, 1] call vgm_g_fnc_zombie_makeNoise;
