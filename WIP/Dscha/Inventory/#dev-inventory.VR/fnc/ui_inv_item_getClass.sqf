
	params[
		["_itemClass",-1,[-1]]
	];
	diag_log str["DEBUG: IMTE_GETCFGCLASS: _itemClass", _itemClass];
	
	if (_itemClass < 0)exitWith{""};
	
	private _ret = switch(_itemClass)do
	{
		case 0: {"CfgMagazines"};	// Inventory Items only
		
		case 2: {"CfgWeapons"};	// Primary Weapon
		case 3: {"CfgWeapons"};	// Handgun
		case 4: {"CfgWeapons"};	// Launcher
		case 5: {"CfgWeapons"};	// Tool (Pickaxe/Hammer)
		
		case 10: {"CfgWeapons"};	// Helmet
		case 11: {"CfgWeapons"};	// Glasses
		case 12: {"CfgWeapons"};	// Uniform
		case 13: {"CfgWeapons"};	// Vest
		case 15: {"CfgWeapons"};	// Backpack
		case 14: {"CfgWeapons"};	// Pouch (extra inventory, nothing else - atm not visible)
		default {"CfgMagazines"};
	};
	// systemchat str["_ret", _ret];
	_ret