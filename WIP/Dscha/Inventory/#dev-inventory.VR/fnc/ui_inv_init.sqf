/*

[]spawn 
{ 
	sleep 1; 
	an_tiles_usage = [];
	(findDisplay 46) createDisplay "an_inventory"; 
};

	///////////////////////////////////////////////////
	///////// ReCompiled at onLoad of Display /////////
	///////////////////////////////////////////////////
*/

//DEV: reset inv usage Var
{
	missionNameSpace setVariable [(format["an_inv_tileUsage_%1",_x]),[]];
}forEach [1000,1001];

#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"



//Grid
an_fnc_ui_inv_grid_check_freeTiles = compile preprocessFileLineNumbers "fnc\ui_inv_grid_check_freeTiles.sqf";
an_fnc_ui_inv_grid_create = compile preprocessFileLineNumbers "fnc\ui_inv_grid_create.sqf";
an_fnc_ui_inv_grid_getSize = compile preprocessFileLineNumbers "fnc\ui_inv_grid_getSize.sqf";
an_fnc_ui_inv_grid_posToGrid = compile preprocessFileLineNumbers "fnc\ui_inv_grid_posToGrid.sqf";
an_fnc_ui_inv_grid_gridToPos = compile preprocessFileLineNumbers "fnc\ui_inv_grid_gridToPos.sqf";
an_fnc_ui_inv_grid_isPosIn = compile preprocessFileLineNumbers "fnc\ui_inv_grid_isPosIn.sqf";
/* DEBUG function:*/ an_fnc_ui_inv_grid_resetColor = compile preprocessFileLineNumbers "fnc\ui_inv_grid_resetColor.sqf";
an_fnc_ui_inv_grid_updateTiles = compile preprocessFileLineNumbers "fnc\ui_inv_grid_updateTiles.sqf";


//handling
an_fnc_ui_inv_item_attachToMouse = compile preprocessFileLineNumbers "fnc\ui_inv_item_attachToMouse.sqf";
an_fnc_ui_inv_item_create = compile preprocessFileLineNumbers "fnc\ui_inv_item_create.sqf";
an_fnc_ui_inv_item_getData = compile preprocessFileLineNumbers "fnc\ui_inv_item_getData.sqf";
an_fnc_ui_inv_item_grab = compile preprocessFileLineNumbers "fnc\ui_inv_item_grab.sqf";
an_fnc_ui_inv_item_remove = compile preprocessFileLineNumbers "fnc\ui_inv_item_remove.sqf";
an_fnc_ui_inv_mpos = compile preprocessFileLineNumbers "fnc\ui_inv_mpos.sqf";
an_fnc_ui_inv_mPos_check = compile preprocessFileLineNumbers "fnc\ui_inv_mPos_check.sqf";
an_fnc_ui_inv_mPos_check_inInv = compile preprocessFileLineNumbers "fnc\ui_inv_mPos_check_inInv.sqf";
an_fnc_ui_inv_EH_mouse_z = compile preprocessFileLineNumbers "fnc\ui_inv_EH_mouse_z.sqf";
an_fnc_ui_inv_EH_mouseBtn = compile preprocessFileLineNumbers "fnc\ui_inv_EH_mouseBtn.sqf";

//////////////////////////////

_parentDefinitions = 
[
	 ["FirstAidKit",[["actions",[["action1",["use FAK","an_fnc_FAK_use",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa"],["name","STR_FirstAidKit"],["size",[2,2]],["slot",0],["tear",0]]]
	,["Medikit",[["actions",[["action1",["use MediKit","an_fnc_MediKit_use",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_Medikit_CA.paa"],["name","STR_MediKit"],["size",[3,3]],["slot",0],["tear",0]]]
	,["PLACEHOLDER",[["actions",[]],["addInvSpace",0],["class_name",""],["hp_max",1],["image","\vn\ui_f_vietnam\data\logo\savage_ca.paa"],["name","PLACEHOLDER"],["size",[2,2]],["slot",0],["tear",0]]]
	,["bandage",[["actions",[["action1",["use Bandage","an_fnc_bandage_use",0,[]]],["actionSomething",["ShowScriptError","an_fnc_iDontExist",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_gps_CA.paa"],["name","STR_Bandage"],["size",[1,1]],["slot",0],["tear",0]]]
	,["boxershorts",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa"],["name","STR_boxershorts"],["size",[3,3]],["slot",0],["tear",0]]]
	,["dildozer9000",[["parent","vn_m14"],["tear",0]]]
	,["launch_NLAW_F",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","launch_NLAW_F"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",3],["tear",7.5]]]
	,["launch_RPG32_F",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","launch_RPG32_F"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",3],["tear",7.5]]]
	,["list_muzzle",[["megauberm14",["vn_s_m14"]],["vn_m14",["vn_s_m14"]],["vn_m14_alternative",["vn_s_m14"]],["vn_m14_lessTearNoScopes",["vn_s_m14"]],["vn_m16",["vn_s_m16"]],["vn_m38",[]],["vn_m4956",[]]]]
	,["list_scope",[["megauberm14",["vn_o_9x_m14","vn_o_anpvs2_m14"]],["vn_m14",["vn_o_9x_m14"]],["vn_m14_alternative",["vn_o_9x_m14","vn_o_anpvs2_m14"]],["vn_m14_lessTearNoScopes",[]],["vn_m16",["vn_o_4x_m16"]],["vn_m38",[]],["vn_m4956",[]]]]
	,["oldSock",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa"],["name","STR_Old_Socks"],["size",[3,3]],["slot",0],["tear",0]]]
	,["trashItem2",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa"],["name","STR_trashItem2"],["size",[2,2]],["slot",0],["tear",0]]]
	,["vn_b_helmet_aph6_01_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_helmet_aph6_01_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",10],["tear",0]]]
	,["vn_b_helmet_m1_01_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_helmet_m1_01_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",10],["tear",0]]]
	,["vn_b_helmet_t56_01_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_helmet_t56_01_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",10],["tear",0]]]
	,["vn_b_pack_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",10],["class_name","vn_b_pack_01"],["hp_max",100],["image",""],["name",""],["size",[8,8]],["slot",12],["tear",0]]]
	,["vn_b_pack_02",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",10],["class_name","vn_b_pack_02"],["hp_max",100],["image",""],["name",""],["size",[8,8]],["slot",12],["tear",0]]]
	,["vn_b_uniform_macv_01_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_uniform_macv_01_01"],["hp_max",100],["image",""],["name",""],["size",[8,4]],["slot",10],["tear",0]]]
	,["vn_b_uniform_sog_01_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_uniform_sog_01_01"],["hp_max",100],["image",""],["name",""],["size",[8,4]],["slot",10],["tear",0]]]
	,["vn_b_uniform_sog_02_04",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_uniform_sog_02_04"],["hp_max",100],["image",""],["name",""],["size",[8,4]],["slot",10],["tear",0]]]
	,["vn_b_vest_aircrew_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_vest_aircrew_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",11],["tear",0]]]
	,["vn_b_vest_sog_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_vest_sog_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",11],["tear",0]]]
	,["vn_b_vest_usarmy_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_b_vest_usarmy_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",11],["tear",0]]]
	,["vn_hd",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_hd"],["hp_max",100],["image",""],["name",""],["size",[2,4]],["slot",2],["tear",0.5]]]
	,["vn_hp",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_hp"],["hp_max",100],["image",""],["name",""],["size",[2,4]],["slot",2],["tear",0.5]]]
	,["vn_izh54",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_izh54"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",1],["tear",0.5]]]
	,["vn_izh54_shorty",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_izh54_shorty"],["hp_max",100],["image",""],["name",""],["size",[3,6]],["slot",1],["tear",0.5]]]
	,["vn_m14",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m14"],["hp_max",100],["image",""],["name",""],["size",[3,6]],["slot",1],["tear",0.5]]]
	,["vn_m14_alternative",[["parent","vn_m14"],["tear",0.25]]]
	,["vn_m14_lessTearNoScopes",[["parent","vn_m14"],["tear",0.1]]]
	,["vn_m16",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m16"],["hp_max",100],["image",""],["name",""],["size",[3,6]],["slot",1],["tear",0.5]]]
	,["vn_m1895",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m1895"],["hp_max",100],["image",""],["name",""],["size",[2,4]],["slot",2],["tear",0.5]]]
	,["vn_m1897",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m1897"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",1],["tear",0.5]]]
	,["vn_m1911",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m1911"],["hp_max",100],["image",""],["name",""],["size",[2,4]],["slot",2],["tear",0.5]]]
	,["vn_m38",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m38"],["hp_max",100],["image",""],["name",""],["size",[3,6]],["slot",1],["tear",0.5]]]
	,["vn_m4956",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m4956"],["hp_max",100],["image",""],["name",""],["size",[3,6]],["slot",1],["tear",0.5]]]
	,["vn_m60",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m60"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",1],["tear",0.05]]]
	,["vn_m60_shorty",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_m60_shorty"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",1],["tear",0.05]]]
	,["vn_o_4x_m16",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_o_4x_m16"],["hp_max",100],["image",""],["name",""],["size",[1,3]],["slot",30],["tear",0]]]
	,["vn_o_9x_m14",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_o_9x_m14"],["hp_max",100],["image",""],["name",""],["size",[1,3]],["slot",30],["tear",0]]]
	,["vn_o_anpvs2_m14",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_o_anpvs2_m14"],["hp_max",100],["image",""],["name",""],["size",[2,4]],["slot",30],["tear",0]]]
	,["vn_o_helmet_nva_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_o_helmet_nva_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",10],["tear",0]]]
	,["vn_o_helmet_vc_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_o_helmet_vc_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",10],["tear",0]]]
	,["vn_o_pack_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",10],["class_name","vn_o_pack_01"],["hp_max",100],["image",""],["name",""],["size",[8,8]],["slot",12],["tear",0]]]
	,["vn_o_pack_02",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",10],["class_name","vn_o_pack_02"],["hp_max",100],["image",""],["name",""],["size",[8,8]],["slot",12],["tear",0]]]
	,["vn_o_uniform_vc_03_02",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_o_uniform_vc_03_02"],["hp_max",100],["image",""],["name",""],["size",[8,4]],["slot",10],["tear",0]]]
	,["vn_o_uniform_vc_mf_01_07",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_o_uniform_vc_mf_01_07"],["hp_max",100],["image",""],["name",""],["size",[8,4]],["slot",10],["tear",0]]]
	,["vn_o_vest_04",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_o_vest_04"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",11],["tear",0]]]
	,["vn_o_vest_vc_01",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",6],["class_name","vn_o_vest_vc_01"],["hp_max",100],["image",""],["name",""],["size",[4,4]],["slot",11],["tear",0]]]
	,["vn_rpd",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_rpd"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",1],["tear",0.05]]]
	,["vn_rpd_shorty",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_rpd_shorty"],["hp_max",100],["image",""],["name",""],["size",[4,8]],["slot",1],["tear",0.05]]]
	,["vn_s_m14",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_s_m14"],["hp_max",100],["image",""],["name",""],["size",[1,3]],["slot",31],["tear",0]]]
	,["vn_s_m16",[["actions",[["placeholder",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]]],["addInvSpace",0],["class_name","vn_s_m16"],["hp_max",100],["image",""],["name",""],["size",[1,3]],["slot",31],["tear",0]]]
];

{
	_x params ["_item_name","_item_data"];
	missionNamespace setVariable [format["AN_ITEM_%1",_item_name], _item_data];
}forEach _parentDefinitions;


an_fnc_item_getCfgClass =
{
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
};


//////////////////////////////

private _disp = _this#0;

an_inv_size_col = 8;	//0-X (so -1 of the actual ColCount) - FIXED SIZE - ALWAYS 8!
// DEV - Will be set by the Backend data
an_inv_size_y = call an_fnc_ui_inv_grid_getSize;

an_inv_move_placeHorizontal = true;	// init
an_ui_inv_grabActive = false;		// init

////// Create Inventory for Player and Ground
// create Player Inventory grid array
diag_log "-----------------------------------------------";
diag_log ["setting up grid: Player Inventory...     "];
private _ctrlGrp_pers = uinamespace getvariable ["an_inv_player_grid", controlNull];
// set the Var for the PERSONAL grid and show the "grid images"
[_disp,_ctrlGrp_pers,an_inv_size_y] call an_fnc_ui_inv_grid_create;
diag_log ["setting up grid: Player Inventory... done"];

diag_log "-----------------------------------------------";
// create "Ground Inventory" grid array
_DEV_cratedata = [
	["crateID","928316315756323"],
	["inv_rows",5],
	["itemData",
		[
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg=="],["invPos",[0,0]],["isFlipped",0],["parent","FirstAidKit"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[0,2]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ=="],["invPos",[2,0]],["isFlipped",0],["parent","PLACEHOLDER"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw=="],["invPos",[0,6]],["isFlipped",0],["parent","PLACEHOLDER"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ=="],["invPos",[2,6]],["isFlipped",0],["parent","PLACEHOLDER"],["rarity",0]]]
		]
	]
];

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

// create the crate grid
diag_log "-----------------------------------------------";
diag_log ["DEBUG: UI_INV_INIT: setting up grid: crate Inventory...     "];
private _grid_rows = ENTRY_GET("inv_rows",_DEV_cratedata);
private _ctrlGrp_cont = uinamespace getvariable ["an_inv_crate_grid", controlNull];
// set the Var for the EXTERNAL grid and show the "grid images"
[_disp,_ctrlGrp_cont,_grid_rows] call an_fnc_ui_inv_grid_create;
diag_log ["DEBUG: UI_INV_INIT: setting up grid: crate Inventory... done"];
diag_log "-----------------------------------------------";


// -------------------- add the Items:
private _crate_ctrl = uinamespace getvariable ["an_inv_crate_grid", controlNull];
private _items = ENTRY_GET("itemData",_DEV_cratedata);

diag_log "-----------------------------------------------";
{
	_x params ["_itemID","_item_data"];
	// get the parent
	private _item_parent = ENTRY_GET("parent",_item_data);
	
	// get the pos, this item was stored in
	private _item_pos = ENTRY_GET("invPos",_item_data);
	//convert from gridPos to uiPos
	([_crate_ctrl, _grid_rows, _item_pos ]call an_fnc_ui_inv_grid_gridToPos) params["_item_pos_y","_item_pos_x"];
	
	//DEBUG
	diag_log ["DEBUG: UI_INV_INIT: _item_parent    :", _item_parent];
	diag_log ["DEBUG: UI_INV_INIT: _item_pos       :", _item_pos];
	
	// set the classname, to create the Item
	missionNameSpace setVariable ["an_inv_itemActive",_item_parent];
	[_crate_ctrl,0,_item_pos_y,_item_pos_x] call an_fnc_ui_inv_mPos;
	diag_log "-----------------------------------------------";
}forEach _items;
diag_log "-----------------------------------------------";

// Handle scrolling the Mousewheel (only if an item is currently grabbed)
_disp displayAddEventhandler ["MouseZChanged","call an_fnc_ui_inv_EH_mouse_z"];





//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
///////DEV

/* 
_disp displayAddEventhandler ["KeyDown",
{
	params ["_disp", "_key", "_shift", "_ctrl", "_alt"];
	_buttonDisabled = false;
	_BD = {_buttonDisabled = true};
	private _item_sel = [];
	if(_key in [2,3,4,5,6])then
	{
		if(_key isEqualTo 2)exitWith{missionNameSpace setVariable ["an_inv_itemActive",DEV_ITEMTOPLACE_LIST#0]; call _BD;};
		if(_key isEqualTo 3)exitWith{missionNameSpace setVariable ["an_inv_itemActive",DEV_ITEMTOPLACE_LIST#1]; call _BD;};
		if(_key isEqualTo 4)exitWith{missionNameSpace setVariable ["an_inv_itemActive",DEV_ITEMTOPLACE_LIST#2]; call _BD;};
		// if(_key isEqualTo 5)then{DEV_ITEMTOPLACE = 3;};
		if(_key isEqualTo 6)then
		{
			//if RMB -> set Var to request rotate by 90°
			an_inv_move_placeHorizontal = !an_inv_move_placeHorizontal;
			 call _BD;
		};
		systemchat str [" DEV_ITEMTOPLACE : ", missionNameSpace getVariable ["an_inv_itemActive",[]], " - Place Horizontal?", an_inv_move_placeHorizontal];
	};
	_buttonDisabled
}];
 */

