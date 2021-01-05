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

params["_dataset_raw"];

_dataset = createHashmap;
_dataset insert _dataset_raw;

private _playerUID = _dataset get "data_puid";
private _player = [_playerUID] call AN_S_fnc_player_get_by_puid;
if(isNull _player)exitWith{diag_log "LOADOUT SET: NO PLAYER FOUND!";};

an_s_fnc_player_gear_uniform_set = {params ["_player","_item"]; removeUniform _player; _player forceAddUniform _item;};
an_s_fnc_player_gear_vest_set = {params ["_player","_item"]; removeVest _player; _player addVest _item;};
an_s_fnc_player_gear_backpack_set = {params ["_player","_item"]; removeBackpackGlobal _player; _player addBackpackGlobal _item;};
an_s_fnc_player_gear_headgear_set = {params ["_player","_item"]; removeHeadgear _player; _player addHeadgear _item;};
an_s_fnc_player_gear_facewear_set = {params ["_player","_item"]; removeGoggles _player; _player addGoggles _item;};
as_s_fnc_player_gear_binocular_set = {params ["_player","_item"]; private _binoCur = binocular _player; _player unassignItem _binoCur; _player removeWeaponGlobal _binoCur; _player addWeaponGlobal _item; _player assignItem _item;};

/*
	ToDo: Weapon attachments
*/

as_s_fnc_player_gear_weapon_main_set = {params ["_player","_item"]; _player removeWeaponGlobal (primaryWeapon _player); _player addWeaponGlobal _item;};
as_s_fnc_player_gear_weapon_handgun_set = {params ["_player","_item"]; _player removeWeaponGlobal (handgunWeapon _player); _player addWeaponGlobal _item;};
as_s_fnc_player_gear_weapon_launcher_set = {params ["_player","_item"]; _player removeWeaponGlobal (secondaryWeapon _player); _player addWeaponGlobal _item;};



private _itemList = _dataset getOrDefault ["data_gear",[]];
// Temp
private _slotHandling = createHashmap;
_slotHandling insert
[
	 ["2012",an_s_fnc_player_gear_uniform_set]
	,["2013",an_s_fnc_player_gear_vest_set]
	,["2015",an_s_fnc_player_gear_backpack_set]
	,["2010",an_s_fnc_player_gear_headgear_set]
	,["2011",an_s_fnc_player_gear_facewear_set]
	,["2017",as_s_fnc_player_gear_binocular_set]
	/*
		ToDo: Weapon attachments
	*/
	
	,["2002",as_s_fnc_player_gear_weapon_main_set]
	,["2003",as_s_fnc_player_gear_weapon_handgun_set]
	,["2004",as_s_fnc_player_gear_weapon_launcher_set]
];

{
	_x params ["_slot", "_classname"];
	diag_log ["DEBUG: LOADOUT SET: Add Item: ", _classname];
	[_player, _classname] call (_slotHandling getOrDefault [_slot,{}]);
}forEach _itemList;



/////////////////////////////////////////////////////////////////////////////////
// DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////////////////////////////////////

if(true)exitWith{};
/*
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

// Following is the standard gear for every player (not planed to be put down nor exchanged)
//_loadout pushback ["vn_o_item_map","","","vn_b_item_compass_sog","vn_b_item_watch",""];

params["_player","_DEV_MAGAZINES"];
uisleep 1;
{
	if !(_x isEqualTo "")then
	{
		_player addMagazines [_x, 3];
	};
}forEach _DEV_MAGAZINES;


*/