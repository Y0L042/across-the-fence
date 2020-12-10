/*
	Get the CfgClass
*/
private _DEBUGON = false;
params[
	["_itemClass",[],[[]]]	// itemClass can have multiple entries. 1st Entry is the "main" info.
];

if(_itemClass isEqualTo [])exitWith{""};

private _ret = switch(_itemClass#0)do
{
	case 0: {"CfgMagazines"};	// Inventory Items only
	
	case 2: {"CfgWeapons"};		// Primary Weapon
	// case 202: {"CfgWeapons"};	// Primary Weapon (second Slot) - Not needed, but just left in here as Overview
	case 3: {"CfgWeapons"};		// Handgun
	case 4: {"CfgWeapons"};		// Launcher
	case 5: {"CfgWeapons"};		// Tool (Pickaxe/Hammer)
	
	case 10: {"CfgWeapons"};	// Helmet
	case 11: {"CfgGlasses"};	// Goggles/Glasses/Balaclava/Facewear
	case 12: {"CfgWeapons"};	// Uniform
	case 13: {"CfgWeapons"};	// Vest
	case 14: {"CfgMagazines"};	// Pouch (extra inventory, nothing else - atm not visible)
	case 15: {"CfgVehicles"};	// Backpack
	case 17: {"CfgWeapons"};	// Bino
	default {"CfgMagazines"};
};
if(_DEBUGON)then{diag_log ["DEBUG: ITEM_GETCFGCLASS: _ret", _ret];};
if(_DEBUGON)then{systemchat str["DEBUG: ITEM_GETCFGCLASS: _ret", _ret];};
_ret
