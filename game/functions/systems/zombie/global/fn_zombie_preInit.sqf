/*
    File: fn_zombie_preInit.sqf
    Author: Savage Game Design
    Date: 2025-10-22
    Last Update: 2025-10-23
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

vgm_g_zombie_initialDamage = 0.45;

vgm_g_zombie_screamerChance = 1 / 3;

vgm_g_zombie_screamAlertRadius = 150;
vgm_g_zombie_screamCooldown = 20;

vgm_g_zombie_alertEventPriorities = createHashMapFromArray [
    ["zombie_alert", 1.25]
];
