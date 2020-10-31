

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];
diag_log ["-------- AN_S_fnc_loadout_set: ---------"];

_data_puid = ENTRY_GET("data_puid",_dataset);
_data_gear = ENTRY_GET("data_gear",_dataset);
_data_pos = ENTRY_GET("data_pos",_dataset);
_data_health = ENTRY_GET("data_health",_dataset);
_data_faction = ENTRY_GET("data_faction",_dataset);

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
// disable any damage to the client, during the init-phase
_ownerPawn allowDamage false;

// rejoin the faction:
private _sideNames = ["WEST", "EAST", "GUER", "CIV"];	// Determined via "side cursorObject"
private _side = [west, east, independent, civilian]#(_sideNames find _data_faction);
[_ownerPawn, _side] call an_s_fnc_factions_set_player_to_faction;


// set the the loadout
{
	diag_log ["DEBUG: AN_S_fnc_loadout_set: _data_gear", _x];
}forEach _data_gear;

private _loadout = [];
// Weapons:
{
	_x params ["_slot", "_defaultValue"];
	// check which Slot if there is an Item with the given SlotID is in:
	private _itemData = [];
	// urgs...
	{
		private _slotID = ENTRY_GET("inSlot", _x);
		if(_slotID == _slot)exitWith{_itemData = _x; _data_gear deleteAt _forEachIndex;};
	}forEach _data_gear;
	diag_log ["-------------------------------------------", _itemData];
	
	//Check if something was found:
	if !(_itemData isEqualTo [])then
	{
		//ToDo: checking and adding Attachments
		_TEMPCLASSNAME = ENTRY_GET("parent",_itemData);

		//	!!!!! WARNING !!!!!
		//	!! NOT FINAL! WILL USE "CLASS_NAME" FROM PARENT LATER !!
		
		if(_defaultValue isEqualType "")then
		{
			_defaultValue = _TEMPCLASSNAME;
		}else{
			_defaultValue set[0,_TEMPCLASSNAME];
		};
		_loadout pushback _defaultValue;
	}else{
		_loadout pushback _defaultValue;
	};
}forEach
[
//	 https://community.bistudio.com/wiki/setUnitLoadout
	 [2,	["","","","",[],[],""] ]
	,[4,	["","","","",[],[],""] ]
	,[3,	["","","","",[],[],""] ]
	,[12,	["",[]] ]
	,[13,	["",[]] ]
	,[15,	["",[]] ]
	,[10,	""]
	,[11,	""]
];


// Following is the standard gear for every player (not planed to be put down nor exchanged)
// Note: Might be nice, having different standard loadouts for each faction.
_loadout pushback ["vn_m19_binocs_grn","","","",[],[],""];	//It's a "weapon", so it needs to be an Array like this...
_loadout pushback ["vn_o_item_map","","","vn_b_item_compass_sog","vn_b_item_watch",""];

_ownerPawn setUnitLoadout _loadout;


// set health:
_data_health = ENTRY_GET("data_health",_dataset);
_ownerPawn setDamage _data_health;

// set Pos and Dir
_data_pos = ENTRY_GET("data_pos",_dataset);
_data_pos params["_pos","_dir"];
_ownerPawn setDir _dir;

if(_pos isEqualTo [0,0,0])then
{
	_ownerPawn setPos markerPos "new_player_spawn";
}else{
	_ownerPawn setPosWorld _pos;
};
diag_log ["DEBUG: AN_S_fnc_loadout_set: curPos", getPosWorld _ownerPawn];

// enable damage again
_ownerPawn allowDamage true;