/*
    File: player_loadout_set.sqf
    Author: Dscha
    Date: 2020-11-03
    Last Update: 2020-11-06
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
if(isNull _player)exitWith{diag_log "LOADOUT SET: NO PLAYER FOUND!";};

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
_DEV_MAGAZINES = ["","",""];
_DEV_MAGAZINES_AMMO = [0,0,0];
// Weapons:
{
	_x params ["_slot", "_dataLayout", "_defaultValue"];
	
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
			_dataLayout = _TEMPCLASSNAME;
		}
		else
		{
			diag_log ["PRE  :", _TEMPCLASSNAME, _dataLayout];
			_dataLayout set[0,_TEMPCLASSNAME];
			diag_log ["POST :", _TEMPCLASSNAME, _dataLayout];
			
			/////////////////////////////////////////////////////////////////////////////////
			// DEV: Add some Magazines, each time the Weapon is changed
			if(_slot in [2,3,4])then
			{
				private _magazineList = getArray(configfile >> "CfgWeapons" >> _TEMPCLASSNAME >> "magazines");
				private _magazine = selectRandom _magazineList;
				if(_magazine isEqualTo [])then
				{
					private _MagWellName = getArray(configfile >> "CfgWeapons" >> _TEMPCLASSNAME >> "magazineWell");
					private _MagWellList = getArray(configfile >> "CfgMagazineWells" >> _MagWellName >> "BI_Magazines");
					if !(_MagWellList isEqualTo [])then
					{
						_magazine = selectRandom _magazineList;
					};
				};
				
				if !(_magazine isEqualTo "")then
				{
					private _magAmmoCount = getNumber(configfile >> "CfgMagazines" >> _magazine >> "count");
					_DEV_MAGAZINES_AMMO set[(_slot - 2),_magAmmoCount];
					
					_dataLayout set[4,[_magazine,_magAmmoCount]];
				};
				
				_DEV_MAGAZINES set[(_slot - 2), _magazine];
			};
			/////////////////////////////////////////////////////////////////////////////////
		};
		diag_log ["FINAL:", _dataLayout];
		_loadout pushback _dataLayout;
	}
	else
	{
		_loadout pushback _defaultValue;
	};
}forEach
[
//	 https://community.bistudio.com/wiki/setUnitLoadout
	 [2,	["","","","",[],[],""],["","","","",[],[],""] ]	// Weapon: Primary
	,[4,	["","","","",[],[],""],["","","","",[],[],""] ]	// Weapon: Launcher
	,[3,	["","","","",[],[],""],["","","","",[],[],""] ]	// Weapon: Secondary
	,[12,	["",[]],[] ]									// Gear: Uniform
	,[13,	["",[]],[] ]									// Gear: Vest
	,[15,	["",[]],[] ]									// Gear: Backpack
	,[10,	"",""]											// Gear: Helmet
	,[11,	"",""]											// Gear: Goggles/Glasses/Balaclava
	,[17,	["","","","",[],[],""],["","","","",[],[],""] ]	// Gear: Binocular
];

/*

_loadout =	[
Index:	0		 ["Weapon: Primary","Muzzle","Flashlight","Optics",["MagazineInWeapon",AmmoCount],[],"Bipod"]
Index:	1		,["Weapon: Launcher","Muzzle","Flashlight","Optics",["MagazineInWeapon",AmmoCount],[],"Bipod"]
Index:	2		,["Weapon: Handgun","Muzzle","Flashlight","Optics",["MagazineInWeapon",AmmoCount],[],"Bipod"]
Index:	3		,["Gear: Uniform",	[ ["FirstAidKit",1],["MiniGrenade",1,1] ] ]	// if Item		: ["FirstAidKit",Amount];
Index:	4		,["Gear: Vest",		[ ["FirstAidKit",1],["MiniGrenade",1,1] ] ]	// if Magazine	: ["MiniGrenade", Amount, Bullets/Rounds]
Index:	5		,["Gear: Backpack",	[ ["FirstAidKit",1],["MiniGrenade",1,1] ] ]	// Magazines can't be "overfilled" with rounds!
Index:	6		,"Gear: Helmet"
Index:	7		,"Gear: Goggles/Glasses/Balaclava"
Index:	8		,["Binocular","","","",[],[],""]	// Binoculars are technically a "weapon", it looks the same as in Index 0-2
Index:	9		,["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]
			]
*/


// Following is the standard gear for every player (not planed to be put down nor exchanged)
// Note: Might be nice, having different standard loadouts for each faction.
_loadout pushback ["vn_o_item_map","","","vn_b_item_compass_sog","vn_b_item_watch",""];

{
	diag_log ["DEBUG: AN_S_fnc_loadout_set: _loadout: ", _x];
}forEach _loadout;

_player setUnitLoadout _loadout;

// Yes... spawned... add some Magazines, after setUnitLoadout is done.
[_player, _DEV_MAGAZINES] spawn
{
	params["_player","_DEV_MAGAZINES"];
	uisleep 1;
	{
		if !(_x isEqualTo "")then
		{
			_player addMagazines [_x, 3];
		};
	}forEach _DEV_MAGAZINES;
};

