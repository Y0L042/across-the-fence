/*
    File: fn_factions_init.sqf
    Author: Spoffy
    Date: 2020-10-08
    Last Update: 2020-10-08
    Public: Yes
    
    Description:
		Initialises the factions.
    
    Parameter(s):
		None
    
    Returns:
		None
    
    Example(s):
		[] call an_s_fnc_factions_init
*/

an_s_recruiters_west = [];
an_s_recruiters_east = [];
an_s_recruiters_independent = [];

[] call an_s_fnc_factions_create_recruiters_at_markers;
