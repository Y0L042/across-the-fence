

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];
diag_log ["-------- AN_S_fnc_loadout_set: ---------"];

_data_puid = ENTRY_GET("data_puid",_dataset);
_data_gear = ENTRY_GET("data_gear",_dataset);

// Get the pawn, related to PUID:
private _timeout = diag_tickTime + 20;
private _ownerPawn = nil;
waitUntil
{
	_ownerPawn = {if(getPlayerUID _x isEqualTo _data_puid)exitWith{_x};}forEach allPlayers;
	(!isNil "_ownerPawn" || _timeout < diag_tickTime)
};
if(_timeout < diag_tickTime)exitWith{diag_log ["ERROR: AN_S_fnc_loadout_set: NO PAWN FOUND (timeout) - _data_puid: ", _data_puid];};
/*
	If found -> Get the classname

	!!!!! WARNING !!!!!
	This script is currently using the "parent" name as classname! This is NOT, how it will be in the end.
	Correct Method would be:
	Get the "class_name" data from the parent! After the Items were finaly added to the itemParentData Definitions, this needs to be adjusted!
	!!!!! WARNING !!!!!
*/

{
	diag_log ["DEBUG: AN_S_fnc_loadout_set: _data_gear", _x];
}forEach _data_gear;

private _loadout = [];
// Weapons:
{
	_x params ["_slot", "_defaulValue"];
	private _tmpData = ENTRY_GET(_slot,_data_gear);
	//Check if the Array or string is filled
	if(count _tmpData > 0)then
	{
		//ToDo: checking and adding Attachments
		_TEMPCLASSNAME = ENTRY_GET("parent",_tmpData);
		/*
			!!!!! WARNING !!!!!
			!! NOT FINAL! WILL USE "CLASS_NAME" FROM PARENT LATER !!
		*/
		if(_defaulValue isEqualType "")then
		{
			_defaulValue = _TEMPCLASSNAME;
		}else{
			_defaulValue set[0,_TEMPCLASSNAME];
		};
		_loadout pushback _defaulValue;
	}else{
		_loadout pushback _defaulValue;
	};
}forEach
[
	["w_main",		["","","","",[],[],""] ],
	["w_launcher",	["","","","",[],[],""] ],
	["w_hand",		["","","","",[],[],""] ],
	["uniform",		["",[]] ],
	["vest",		["",[]] ],
	["backpack",	["",[]] ],
	["helmet",		""],
	["goggles",		""]
];

//Following is the standard gear for every player (not planed to be put down nor exchanged)
_loadout pushback ["vn_m19_binocs_grn","","","",[],[],""];	//It's a "weapon", so it needs to be an Array like this...
_loadout pushback ["vn_o_item_map","","","vn_b_item_compass_sog","vn_b_item_watch",""];

_ownerPawn setUnitLoadout _loadout;