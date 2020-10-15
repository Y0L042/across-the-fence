
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


/*
	ASC_init
	post init function
*/

// systemchat str ["ASC - INIT LOADED - CLIENT"];
diag_log str ["ASC - INIT LOADED - CLIENT"];

// set the Callback Eventhandler - Don't let a Dedicated Server load it
if(!isDedicated)then
{
	addMissionEventHandler ["ExtensionCallback", AN_C_fnc_ext_CE_callback_client];
};


//////////////// DEV STUFF ////////////////
if hasInterface then
{
	// player addAction ["ASC: itemAdd [0,0]",				{["itemAdd", 		["MjAyMC0wOC0xMFQyMDoxNTozMS45NTk5NTEtMQ==", getPlayerUID player, 0, [0,0]]] call AN_G_fnc_msg_send;}];
	// player addAction ["ASC: itemAdd [1,1]",				{["itemAdd", 		["MjAyMC0wOC0xMFQyMDoxNTozMS45NTk5NTEtMQ==", getPlayerUID player, 0, [1,1]]] call AN_G_fnc_msg_send;}];
	// player addAction ["ASC: getGrid",					{["inv_get_grid",	[(cursorObject getVariable ["crateID","-1"])]] call AN_G_fnc_msg_send;}];
	// player addAction ["ASC: getItems",					{["inv_get_items",	[(cursorObject getVariable ["crateID","-1"])]] call AN_G_fnc_msg_send;}];
	// player addAction ["ASC: toInv [0,1] Flipped: 0",	{["itemMove",		["MjAyMC0wOC0xMFQyMDoxNTozMS45NTk5NTEtMQ==", (cursorObject getVariable ["crateID","-1"]),	getPlayerUID player,	0,		[0,1]	]] call AN_G_fnc_msg_send;}];
	// player addAction ["ASC: toInv [0,1] Flipped: 1",	{["itemMove",		["MjAyMC0wOC0xMFQyMDoxNTozMS45NTk5NTEtMQ==", (cursorObject getVariable ["crateID","-1"]),	getPlayerUID player,	1,		[0,1]	]] call AN_G_fnc_msg_send;}];
	//																 		[ ITEM ID									   OLD INVENTORY ID,							NEW  INVENTORY ID,	flipped		NewInvPos]	
	// player addAction ["ASC: toCrate [0,0] Flipped: 0",	{["itemMove",		["MjAyMC0wOC0xMFQyMDoxNTozMS45NTk5NTEtMQ==", getPlayerUID player,	(cursorObject getVariable ["crateID","-1"]),	0,		[0,0]	]] call AN_G_fnc_msg_send;}];
	// player addAction ["ASC: toCrate [0,0] Flipped: 1",	{["itemMove",		["MjAyMC0wOC0xMFQyMDoxNTozMS45NTk5NTEtMQ==", getPlayerUID player,	(cursorObject getVariable ["crateID","-1"]),	1,		[0,0]	]] call AN_G_fnc_msg_send;}];
	//																 		[ ITEM ID									   OLD INVENTORY ID,	NEW  INVENTORY ID,							flipped		NewInvPos]	
	// player addAction ["ASC: Create Crate (Temporary)",	{["Land_Suitcase_F",		false, (getPos player), (getDir player), [9,8]] remoteExecCall ["AN_S_fnc_crate_create", 2];}];
	// player addAction ["ASC: Create Crate (Persistent)",	{["Land_WoodenCrate_01_F",	true , (getPos player), (getDir player), [5,8]] remoteExecCall ["AN_S_fnc_crate_create", 2];}];
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

