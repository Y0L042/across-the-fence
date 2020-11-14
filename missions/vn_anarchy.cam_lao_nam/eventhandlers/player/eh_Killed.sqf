/*
    File: eh_Killed.sqf
    Author: Aaron Clark <vbawol>, Dscha
    Date: 2020-05-13
    Last Update: 2020-11-14
    Public: No

    Description:
		Player Killed Event Handler.

    Parameter(s):
		_unit - Description [DATATYPE, defaults to DEFAULTVALUE]
		_killer - Description [DATATYPE, defaults to DEFAULTVALUE]
		_instigator - Description [DATATYPE, defaults to DEFAULTVALUE]
		_useEffects - Description [DATATYPE, defaults to DEFAULTVALUE]

    Returns: nothing

    Example(s):
		Not called directly.
*/

params
[
	"_unit",
	"_killer",
	"_instigator",
	"_useEffects"
];

// disable build mode
para_l_buildmode = nil;
para_l_placing = false;

// Reset the slotted IventoryItems on the player
{ [_x] call an_c_fnc_ui_inv_item_slotted_remove; }forEach[2,3,10,12,13,15];