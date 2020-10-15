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

#include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"



// Grid
an_c_fnc_ui_inv_grid_check_freeTiles = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_check_freeTiles.sqf";
an_c_fnc_ui_inv_grid_create = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_create.sqf";
an_c_fnc_ui_inv_grid_getSize = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_getSize.sqf";
an_c_fnc_ui_inv_grid_posToGrid = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_posToGrid.sqf";
an_c_fnc_ui_inv_grid_gridToPos = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_gridToPos.sqf";
an_c_fnc_ui_inv_grid_isPosIn = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_isPosIn.sqf";
/* DEBUG function:*/ an_c_fnc_ui_inv_grid_resetColor = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_resetColor.sqf";
an_c_fnc_ui_inv_grid_tiles_used_update = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_tiles_used_update.sqf";
an_c_fnc_ui_inv_grid_tiles_used_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_tiles_used_get.sqf";
an_c_fnc_ui_inv_grid_tiles_used_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_tiles_used_set.sqf";
// Item handling
an_c_fnc_ui_inv_load = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_load.sqf";
an_c_fnc_ui_inv_item_active_class_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_active_class_get.sqf";
an_c_fnc_ui_inv_item_active_class_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_active_class_set.sqf";
an_c_fnc_ui_inv_item_attachToMouse = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_attachToMouse.sqf";
an_c_fnc_ui_inv_item_create = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_create.sqf";
an_c_fnc_ui_inv_item_grab = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_grab.sqf";
an_c_fnc_ui_inv_item_move_auto = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_move_auto.sqf";
an_c_fnc_ui_inv_item_remove = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_remove.sqf";
an_c_fnc_ui_inv_item_getClass = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_getClass.sqf";
an_c_fnc_ui_inv_item_data_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_set.sqf";
an_c_fnc_ui_inv_item_data_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_get.sqf";
an_c_fnc_ui_inv_item_data_parent_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_parent_set.sqf";
an_c_fnc_ui_inv_item_data_parent_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_parent_get.sqf";
an_c_fnc_ui_inv_item_slots_usage_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slots_usage_get.sqf";
an_c_fnc_ui_inv_item_slots_find_free = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slots_find_free.sqf";
// mousePos commands
an_c_fnc_ui_inv_mpos = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_mpos.sqf";
an_c_fnc_ui_inv_mPos_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_mPos_check.sqf";
an_c_fnc_ui_inv_mPos_check_inInv = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_mPos_check_inInv.sqf";
an_c_fnc_ui_inv_mPos_get_inv = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_mPos_get_inv.sqf";
// Eventhandler
an_c_fnc_ui_inv_EH_mouse_z = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_EH_mouse_z.sqf";
an_c_fnc_ui_inv_EH_mouseBtn = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_EH_mouseBtn.sqf";

//////////////////////////////

_parentDefinitions = 
[
	 ["FirstAidKit",[["actions",[["action1",["use FAK","an_c_fnc_FAK_use",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa"],["name","STR_FirstAidKit"],["size",[2,2]],["slot",0],["tear",0]]]
	,["Medikit",[["actions",[["action1",["use MediKit","an_c_fnc_MediKit_use",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_Medikit_CA.paa"],["name","STR_MediKit"],["size",[3,3]],["slot",0],["tear",0]]]
	,["PLACEHOLDER",[["actions",[]],["addInvSpace",0],["class_name",""],["hp_max",1],["image","\vn\ui_f_vietnam\data\logo\savage_ca.paa"],["name","PLACEHOLDER"],["size",[2,2]],["slot",0],["tear",0]]]
	,["bandage",[["actions",[["action1",["use Bandage","an_c_fnc_bandage_use",0,[]]],["actionSomething",["ShowScriptError","an_c_fnc_iDontExist",0,[]]]]],["addInvSpace",0],["class_name",""],["hp_max",100],["image","\A3\Weapons_F\Items\data\UI\gear_gps_CA.paa"],["name","STR_Bandage"],["size",[1,1]],["slot",0],["tear",0]]]
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
	_x call an_c_fnc_ui_inv_item_data_parent_set;
}forEach _parentDefinitions;


//////////////////////////////

private _disp = _this#0;


AN_INVENTORY_LIST = [["an_inv_player_area","an_inv_player_grid"],["an_inv_crate_area","an_inv_crate_grid"]];

an_inv_size_col = 8;	//0-X (so -1 of the actual ColCount) - FIXED SIZE - ALWAYS 8!
// DEV - Will be set by the Backend data
an_inv_size_y = call an_c_fnc_ui_inv_grid_getSize;

an_inv_move_placeHorizontal = true;	// init
an_ui_inv_grabActive = false;		// init

////// Create Inventory for Player and Ground
// create Player Inventory grid array
diag_log "-----------------------------------------------";
// DEV VALUES
private _inv_player =
[
	["crateID","76561197960553643"],
	["inv_rows",20],
	["itemData",
		[
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg=="],["invPos",[0,0]],["isFlipped",0],["parent","FirstAidKit"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[0,2]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ=="],["invPos",[2,0]],["isFlipped",0],["parent","PLACEHOLDER"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw=="],["invPos",[0,6]],["isFlipped",0],["parent","PLACEHOLDER"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ=="],["invPos",[2,6]],["isFlipped",0],["parent","PLACEHOLDER"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[4,0]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[4,4]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[8,0]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[8,4]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[12,0]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[12,4]],["isFlipped",0],["parent","vn_o_helmet_nva_01"],["rarity",0]]]
		]
	]
];
[_disp, "an_inv_player_grid", _inv_player] call an_c_fnc_ui_inv_load;

diag_log "-----------------------------------------------";

// create "Ground Inventory" grid array
// DEV VALUES
_DEV_cratedata = [
	["crateID","928316315756323"],
	["inv_rows",6],
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
[_disp, "an_inv_crate_grid", _DEV_cratedata] call an_c_fnc_ui_inv_load;

diag_log "-----------------------------------------------";

// Handle scrolling the Mousewheel (only if an item is currently grabbed)
_disp displayAddEventhandler ["MouseZChanged","call an_c_fnc_ui_inv_EH_mouse_z"];



