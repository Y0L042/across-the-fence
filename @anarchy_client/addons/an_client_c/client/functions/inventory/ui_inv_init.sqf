
  /////////////////////////////////////////////////
 // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////


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

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

// #include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

// Reset the previous tileUsage, it gets rebuild anyway (better safe than sorry)
{
	localNamespace setVariable [(format["an_inv_tileUsage_%1",_x]),[]];
}forEach [1000,1001];


params["_dataCrate"];

diag_log [":::: DEBUG: UI_INV_INIT: DATA:"];
private _crate_itemData	= ENTRY_GET("itemData",_dataCrate);

diag_log [":::: DEBUG: UI_INV_INIT: ItemData:"];
{
	diag_log _x;
}forEach _crate_itemData;

// Check, if inventory is already open. Close it then.
private _disp_preCheck = uiNamespace getVariable ["an_inventory", displayNull];
if !(isNull _disp_preCheck)then{_disp_preCheck closeDisplay 1;};
private _disp = (findDisplay 46) createDisplay "an_inventory";

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
	["inv_rows",30],
	["itemData",
		[
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg=="],["invPos",[0,0]],["isFlipped",0],["parent","FirstAidKit"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ=="],["invPos",[2,0]],["isFlipped",0],["parent","PLACEHOLDER"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw=="],["invPos",[4,0]],["isFlipped",0],["parent","PLACEHOLDER"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ=="],["invPos",[6,0]],["isFlipped",0],["parent","PLACEHOLDER"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[0,2]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[0,5]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[3,2]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[3,5]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[6,2]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[6,5]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]]
		]
	]
];
[_disp, "an_inv_player_grid", _inv_player] call an_c_fnc_ui_inv_load;

diag_log "-----------------------------------------------";
/*

// create "Ground Inventory" grid array
// DEV VALUES
_dataCrate = [
	["crateID","928316315756323"],
	["inv_rows",6],
	["itemData",
		[
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMg=="],["invPos",[0,0]],["isFlipped",0],["parent","FirstAidKit"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtMw=="],["invPos",[0,2]],["isFlipped",0],["parent","vn_o_helmet_nva_01"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDEzNjUtNQ=="],["invPos",[2,0]],["isFlipped",0],["parent","PLACEHOLDER"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtNw=="],["invPos",[0,6]],["isFlipped",0],["parent","PLACEHOLDER"]]],
			["MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ==",[["attachments",[]],["curInv","928316315756323"],["hp_cur",100],["hp_max",100],["id","MjAyMC0wOS0yMVQwMzo0MTo0MC4wNDYzNjUtOQ=="],["invPos",[2,6]],["isFlipped",0],["parent","PLACEHOLDER"]]]
		]
	]
];
*/

[_disp, "an_inv_crate_grid", _dataCrate] call an_c_fnc_ui_inv_load;

diag_log "-----------------------------------------------";

// Handle scrolling the Mousewheel (only if an item is currently grabbed)
_disp displayAddEventhandler ["MouseZChanged","call an_c_fnc_ui_inv_EH_mouse_z"];



