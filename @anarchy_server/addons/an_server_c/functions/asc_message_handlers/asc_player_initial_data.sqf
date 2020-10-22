/*
	File: fn_asc_player_initial_data.sqf
	Author: Spoffy
	Date: 2020-10-22
	Last Update: 2020-10-22
	Public: No
	
	Description:
		Receives the initial data for the player from the server, and sets variables to be used by their init script.
	
	Parameter(s):
		_dataset - Data from ASC
	
	Returns:
		None
	
	Example(s):
		None
*/
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params ["_dataset"];

private _uid = ENTRY_GET("data_puid", _dataset);
private _playerData = _uid call an_s_fnc_asc_player_data_get;

private _dataGear = ENTRY_GET("data_gear",_dataset);

// set the the loadout
{
	diag_log ["DEBUG: AN_S_fnc_loadout_set: _dataGear", _x];
} forEach _dataGear;

private _loadout = [];
// Weapons:
{
	_x params ["_slot", "_defaultValue"];
	private _tmpData = ENTRY_GET(_slot,_dataGear);
	//Check if the Array or string is filled
	if(count _tmpData > 0)then
	{
		//ToDo: checking and adding Attachments
		private _tempClassName = ENTRY_GET("parent",_tmpData);
		/*
			!!!!! WARNING !!!!!
			!! NOT FINAL! WILL USE "CLASS_NAME" FROM PARENT LATER !!
		*/
		if(_defaultValue isEqualType "")then
		{
			_defaultValue = _tempClassName;
		}else{
			_defaultValue set[0,_tempClassName];
		};
		_loadout pushback _defaultValue;
	}else{
		_loadout pushback _defaultValue;
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

// Following is the standard gear for every player (not planed to be put down nor exchanged)
// Note: Might be nice, having different standard loadouts for each faction.
_loadout pushback ["vn_m19_binocs_grn","","","",[],[],""];	//It's a "weapon", so it needs to be an Array like this...
_loadout pushback ["vn_o_item_map","","","vn_b_item_compass_sog","vn_b_item_watch",""];

_playerData setVariable ["initial_loadout", _loadout];
_playerData setVariable ["initial_position",  ENTRY_GET("data_pos",_dataset)];
_playerData setVariable ["initial_health", ENTRY_GET("data_health", _dataset)];

private _factionName = ENTRY_GET("data_faction", _dataset);
private _sideNames = ["WEST", "EAST", "GUER", "CIV"];	// Determined via "side cursorObject"
private _side = [west, east, independent, civilian] select (_sideNames find _factionName);
_playerData setVariable ["initial_faction", _side];

//Test position setting
//Update backend to call new load function
//Load initial data in player_init_server
//Test

//Mark initial data as received
_playerData setVariable ["initial_data_received", true];