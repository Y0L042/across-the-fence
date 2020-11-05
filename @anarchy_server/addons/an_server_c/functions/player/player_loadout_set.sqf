/*
    File: player_health_set.sqf
    Author: Dscha
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Prepares and sets the currently worn Gear of the given player.

		Player pawn *must exist when this function is called*
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset = [
						 ["data_puid",123456]
						,["data_gear", [ITEMDATA ARRAY, ITEMDATA ARRAY] ]
					]
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];

private _playerUID = ENTRY_GET("data_puid",_dataset);
private _player = [_playerUID] call AN_S_fnc_player_get_by_puid;
if(isNull _player)exitWith{};

/*
private _timeout = diag_tickTime + 20;
private _player = nil;
waitUntil
{
	_player = {if(getPlayerUID _x isEqualTo _dataPuid)exitWith{_x};}forEach allPlayers;
	(!isNil "_player" || _timeout < diag_tickTime)
};
if(_timeout < diag_tickTime)exitWith{diag_log ["ERROR: AN_S_fnc_loadout_set: NO PAWN FOUND (timeout) - _dataPuid: ", _dataPuid];};
*/
/*
	If found -> Get the classname

	!!!!! WARNING !!!!!
	This script is currently using the "parent" name as classname! This is NOT, how it will be in the end.
	Correct Method would be:
	Get the "class_name" data from the parent! After the Items were finaly added to the itemParentData Definitions, this needs to be adjusted!
	!!!!! WARNING !!!!!
*/


_dataGear = ENTRY_GET("data_gear",_dataset);

// DEBUG STUFF:
{ diag_log ["DEBUG: AN_S_fnc_loadout_set: _dataGear", _x]; }forEach _dataGear;

// set the the loadout
private _loadout = [];
// Weapons:
{
	_x params ["_slot", "_defaultValue"];
	
	// check if there is an Item with the given SlotID:
	private _itemData = [];
	// urgs...
	{
		private _slotID = ENTRY_GET("inSlot", _x);
		if(_slotID == _slot)exitWith{_itemData = _x; _dataGear deleteAt _forEachIndex;};
	}forEach _dataGear;
	
	// Check if something was found:
	if !(_itemData isEqualTo [])then
	{
		// ToDo: checking and adding Attachments
		// ToDo: get Ammo, add magazine and fill it with the amount of last saved state
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
	 [2,	["","","","",[],[],""] ]	// ["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",[],[],""],
	,[4,	["","","","",[],[],""] ]	// [],
	,[3,	["","","","",[],[],""] ]	// ["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],
	,[12,	["",[]] ]					// ["U_B_CombatUniform_mcam",[ ["30Rnd_65x39_caseless_mag",2,1] ]],
	,[13,	["",[]] ]					// ["V_PlateCarrier1_rgr",[]],
	,[15,	["",[]] ]					// ["B_AssaultPack_mcamo_Ammo",[]],
	,[10,	""]							// "H_HelmetB_grass",
	,[11,	""]							// "",
];


// Following is the standard gear for every player (not planed to be put down nor exchanged)
// Note: Might be nice, having different standard loadouts for each faction.
_loadout pushback ["vn_m19_binocs_grn","","","",[],[],""];	//It's a "weapon", so it needs to be an Array like this...
_loadout pushback ["vn_o_item_map","","","vn_b_item_compass_sog","vn_b_item_watch",""];

_player setUnitLoadout _loadout;


