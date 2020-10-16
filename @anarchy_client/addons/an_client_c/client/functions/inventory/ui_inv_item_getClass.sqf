/*
	Get the CfgClass
*/
params[
	["_itemClass",-1,[-1]]
];

if (_itemClass < 0)exitWith{""};

private _ret = switch(_itemClass)do
{
	case 0: {"CfgMagazines"};	// Inventory Items only
	
	case 2: {"CfgWeapons"};		// Primary Weapon
	case 3: {"CfgWeapons"};		// Handgun
	case 4: {"CfgWeapons"};		// Launcher
	case 5: {"CfgWeapons"};		// Tool (Pickaxe/Hammer)
	
	case 10: {"CfgVehicles"};	// Helmet
	case 11: {"CfgWeapons"};	// Glasses TODO: Check class
	case 12: {"CfgWeapons"};	// Uniform
	case 13: {"CfgVehicles"};	// Vest
	case 15: {"CfgVehicles"};	// Backpack
	case 14: {"CfgMagazines"};	// Pouch (extra inventory, nothing else - atm not visible)
	default {"CfgMagazines"};
};
diag_log str["DEBUG: ITEM_GETCFGCLASS: _ret", _ret];
// systemchat str["_ret", _ret];
_ret
