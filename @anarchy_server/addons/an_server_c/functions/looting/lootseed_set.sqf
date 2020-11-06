/*
    File: asc_lootseed_set.sqf
    Author: Dscha
    Date: 2020-11-05
    Last Update: 2020-11-05
    Public: No
    
    Description:
        Sets the Lootseed, for Loot positions.
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset =	[
						 ["lootseed",123456]
					]
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];

an_g_loot_pos_seed = ENTRY_GET("lootseed",_dataset);

// make the seed public
missionNamespace setVariable ["an_g_loot_pos_seed", an_g_loot_pos_seed, true];
diag_log ["DEBUG: SETTING LOOT POS SEED: ", an_g_loot_pos_seed];