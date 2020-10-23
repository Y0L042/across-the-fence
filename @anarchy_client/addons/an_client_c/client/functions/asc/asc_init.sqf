
  /////////////////////////////////////////////////
 // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////

// Inventory init file
an_c_fnc_ui_inv_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_init.sqf";
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
an_c_fnc_ui_inv_item_active_id_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_active_id_set.sqf";
an_c_fnc_ui_inv_item_active_id_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_active_id_get.sqf";
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


/*
	ASC_init
	post init function
*/

diag_log str ["ASC - INIT LOADED - CLIENT"];

// set the Callback Eventhandler - Don't let a Dedicated Server load it
if(!isDedicated)then
{
	addMissionEventHandler ["ExtensionCallback", AN_C_fnc_ext_CE_callback_client];
};




  /////////////////////////////////////////////////
 // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////
if hasInterface then
{
	player addAction["ASC: get crateData", {[] call AN_C_fnc_loot_inv_request;}, nil, 1.5, true, true, "", "cursorObject in vn_an_crates", 5, false];
};


DEV_an_fnc_hintGrid =
{
	params["_grid"];
	
	_formated = "";
	{
		_formated = format["%1\n%2", _formated, _x];
	}foreach _grid;
	
	hintsilent _formated;
};


an_fnc_bandage_use = {systemChat str["FUNCTION CALLED: an_fnc_bandage_use"];};
an_fnc_FAK_use = {systemChat str["FUNCTION CALLED: an_fnc_FAK_use"];};
an_fnc_MediKit_use = {systemChat str["FUNCTION CALLED: an_fnc_MediKit_use"];};


 ////////////////////////////////////////////////
////////////////////////////////////////////////