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
	localNamespace setVariable [(format["an_inv_tileUsage_%1",_x]),[]];
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
an_c_fnc_ui_inv_grid_tiles_used_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_tiles_used_set.sqf";
an_c_fnc_ui_inv_grid_tiles_used_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_tiles_used_get.sqf";
// Item handling
an_c_fnc_ui_inv_load = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_load.sqf";
an_c_fnc_ui_inv_item_active_class_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_active_class_set.sqf";
an_c_fnc_ui_inv_item_active_class_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_active_class_get.sqf";
an_c_fnc_ui_inv_item_attachToMouse = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_attachToMouse.sqf";
an_c_fnc_ui_inv_item_create = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_create.sqf";
an_c_fnc_ui_inv_item_grab = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_grab.sqf";
an_c_fnc_ui_inv_item_move_auto = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_move_auto.sqf";
an_c_fnc_ui_inv_item_remove = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_remove.sqf";
an_c_fnc_ui_inv_item_getClass = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_getClass.sqf";
an_c_fnc_ui_inv_item_data_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_init.sqf";
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



