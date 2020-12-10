
  /////////////////////////////////////////////////
 // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////
// reload and update the functions

// Inventory init file
an_c_fnc_ui_inv_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_init.sqf";
an_c_fnc_ui_inv_data_update = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_data_update.sqf";
// Grid
an_c_fnc_ui_inv_grid_check_freeTiles = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_check_freeTiles.sqf";
an_c_fnc_ui_inv_grid_getSize = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_getSize.sqf";
an_c_fnc_ui_inv_grid_posToGrid = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_posToGrid.sqf";
an_c_fnc_ui_inv_grid_gridToPos = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_gridToPos.sqf";
an_c_fnc_ui_inv_grid_isPosIn = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_isPosIn.sqf";
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
an_c_fnc_ui_inv_item_move_auto_slot = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_move_auto_slot.sqf";
an_c_fnc_ui_inv_item_remove = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_remove.sqf";
an_c_fnc_ui_inv_item_drop_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_drop_check.sqf";
an_c_fnc_ui_inv_item_getClass = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_getClass.sqf";
an_c_fnc_ui_inv_item_data_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_init.sqf";
an_c_fnc_ui_inv_item_data_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_set.sqf";
an_c_fnc_ui_inv_item_data_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_get.sqf";
an_c_fnc_ui_inv_item_data_parent_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_parent_get.sqf";
an_c_fnc_ui_inv_item_size_calc = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_size_calc.sqf";
an_c_fnc_ui_inv_item_space_usage_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_space_usage_get.sqf";
an_c_fnc_ui_inv_item_space_find_free = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_space_find_free.sqf";
an_c_fnc_ui_inv_item_space_find_free_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_space_find_free_check.sqf";
an_c_fnc_ui_inv_item_slotted_add = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slotted_add.sqf";
an_c_fnc_ui_inv_item_slotted_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slotted_get.sqf";
an_c_fnc_ui_inv_item_slotted_remove = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slotted_remove.sqf";
// mousePos commands
an_c_fnc_ui_inv_mpos = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_mpos.sqf";
an_c_fnc_ui_inv_mPos_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_mPos_check.sqf";
an_c_fnc_ui_inv_get_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_get_check.sqf";
an_c_fnc_ui_inv_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_get.sqf";
// Eventhandler
an_c_fnc_ui_inv_EH_mouse_z = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_EH_mouse_z.sqf";
an_c_fnc_ui_inv_EH_mouseBtn = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_EH_mouseBtn.sqf";
an_c_fnc_ui_inv_EH_keyHandler = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_EH_keyHandler.sqf";

an_c_fnc_loot_inv_request = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\looting\loot_inv_request.sqf";



// Dev Functions for Inventory Interactions!
/*
	1. Request will be send to the backend , that one will check if all the conditions are met.
	2. If there are differences to the data send by the client and the data on the Backend ->
	3. Command will be send to the Server and back to the client to reset "things"
	
	Example:
	Health:
	1. ItemID and "action Tag" of the MedKit is send back to the backend, requesting ActionX to execute
	2. Backend checks, if he has a MedKit
		True:
			- Server sends playerID and the "setDamage" Tag to the Server
			- Server waits, until the Animation/Timer has run out
			- Executes the setDamage command on the client
		False:
			- Nothing will be executed for the Client
			- Inventory ForceRefresh will be send to the Client
*/
an_fnc_bandage_use = 
{
	params["_ctrl"];
	systemChat format["Bandage used: Health: %1", round(100-(damage player)*100)];
	private _dmgCur = damage player;
	if(_dmgCur > 0)then
	{
		[_ctrl] call an_c_fnc_ui_inv_item_remove;
		_dmgCur = _dmgCur - 0.15;
		player setDamage _dmgCur;
		systemChat format["Bandage used: Health: %1", round(100-(damage player)*100)];
	};
};
an_fnc_FAK_use = 
{
	params["_ctrl"];
	systemChat format["FirstAidKit used: Health: %1", round(100-(damage player)*100)];
	private _dmgCur = damage player;
	if(_dmgCur > 0)then
	{
		[_ctrl] call an_c_fnc_ui_inv_item_remove;
		_dmgCur = _dmgCur - 0.3;
		player setDamage _dmgCur;
		systemChat format["FirstAidKit used: Health: %1", round(100-(damage player)*100)];
	};
};
an_fnc_MediKit_use =
{
	params["_ctrl"];
	systemChat format["MediKit used: Health: %1", round(100-(damage player)*100)];
	private _dmgCur = damage player;
	if(_dmgCur > 0)then
	{
		[_ctrl] call an_c_fnc_ui_inv_item_remove;
		_dmgCur = 0;
		player setDamage _dmgCur;
		systemChat format["MediKit used: Health: %1", round(100-(damage player)*100)];
		
	};
};
AN_C_FNC_PLACEHOLDER = {systemChat str["FUNCTION CALLED: PLACEHOLDER"];};


/////////////////////////////////////////////////

/////////////////////////////////////////////////

////////////////////////////////////////////////
/*
AN_data_inventory =
[
	 "crateID",
		getPlayerUID player
	,"inventory",
		[
			 ["1013",[ ["inv_rows",5],	["inv_cols",8]], ["invID",1013],	["invGrid","an_inv_vst_grid"],		["invArea","an_inv_vst_area"],		]
			,["2202",[ ["inv_rows",3],	["inv_cols",6]], ["invID",202],		["invGrid","an_slot_wpn_b_grid"],	["invArea","an_slot_wpn_b_area"]	]
			,["1012",[ ["inv_rows",16],	["inv_cols",8]], ["invID",1012],	["invGrid","an_inv_uni_grid"],		["invArea","an_inv_uni_area"]		]
			,["1015",[ ["inv_rows",7],	["inv_cols",8]], ["invID",1015],	["invGrid","an_inv_bkp_grid"],		["invArea","an_inv_bkp_area"]		]
			,["2010",[ ["inv_rows",3],	["inv_cols",3]], ["invID",10],		["invGrid","an_slot_hel_grid"],		["invArea","an_slot_hel_area"]		]
			,["1014",[ ["inv_rows",6],	["inv_cols",8]], ["invID",1014],	["invGrid","an_inv_pch_grid"],		["invArea","an_inv_pch_area"]		]
			,["2011",[ ["inv_rows",2],	["inv_cols",2]], ["invID",11],		["invGrid","an_slot_gog_grid"],		["invArea","an_slot_gog_area"]		]
			,["2012",[ ["inv_rows",6],	["inv_cols",4]], ["invID",12],		["invGrid","an_slot_uni_grid"],		["invArea","an_slot_uni_area"]		]
			,["2013",[ ["inv_rows",4],	["inv_cols",4]], ["invID",13],		["invGrid","an_slot_vst_grid"],		["invArea","an_slot_vst_area"]		]
			,["2015",[ ["inv_rows",4],	["inv_cols",4]], ["invID",15],		["invGrid","an_slot_bkp_grid"],		["invArea","an_slot_bkp_area"]		]
			,["2003",[ ["inv_rows",2],	["inv_cols",4]], ["invID",3],		["invGrid","an_slot_sec_grid"],		["invArea","an_slot_sec_area"]		]
			,["2002",[ ["inv_rows",3],	["inv_cols",6]], ["invID",2],		["invGrid","an_slot_wpn_grid"],		["invArea","an_slot_wpn_area"]		]
			,["2017",[ ["inv_rows",3],	["inv_cols",3]], ["invID",17],		["invGrid","an_slot_bin_grid"],		["invArea","an_slot_bin_area"]		]
		]
	,"itemData",
		[
			 ["MjAyMC0xMi0wOVQyMDo1Mjo0MS42NTc3MTYtMQ==",[["inSlot",12],["hp_cur",100],["hp_max",100],["parent","vn_b_uniform_macv_01_06"],["id","MjAyMC0xMi0wOVQyMDo1Mjo0MS42NTc3MTYtMQ=="],["curInv","01234567890123456"],["invPos",[0,0]],["attachments",[]],["isFlipped",0]]]
			,["MjAyMC0xMi0wOVQyMDo1Mjo0MS42NTc3MTYtMg==",[["inSlot",10],["hp_cur",100],["hp_max",100],["parent","vn_b_bandana_03"],["id","MjAyMC0xMi0wOVQyMDo1Mjo0MS42NTc3MTYtMg=="],["curInv","01234567890123456"],["invPos",[0,0]],["attachments",[]],["isFlipped",0]]]
		]
];
*/



private _DEBUGON = true;
// #include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"
// #include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

if!(isNull objectParent player)exitWith{systemchat "DEBUG: Inventory currently blocked, while being in a vehicle!"};
if!(alive player)exitWith{};

params["_dataCrate_raw"];

an_inv_move_placeHorizontal = true;	// init
an_ui_inv_grabActive = false;		// init

////////////////////////////////////////////////////////////////////////////////////////
// Check, if inventory is already open. Close it, then reopen it again.
private _disp_preCheck = uiNamespace getVariable ["an_inventory", displayNull];
if !(isNull _disp_preCheck)then{_disp_preCheck closeDisplay 1;};
private _disp = (findDisplay 46) createDisplay "an_inventory";


////////////////////////////////////////////////////////////////////////////////////////
// Set the Headers:
// Personal Area (playername)
private _ctrlPersonalHeader = uinamespace getvariable ["an_inv_header_personal", controlNull];
_ctrlPersonalHeader ctrlSetText name player;

// External Area (Ground/Crate)
private _ctrlExternalHeader = uinamespace getvariable ["an_inv_header_external", controlNull];
private _useGround = player getVariable["an_inv_dropActive",false];
if(_useGround)then	{ _ctrlExternalHeader ctrlSetText "Ground"; }
else				{ _ctrlExternalHeader ctrlSetText "Crate"; };


////////////////////////////////////////////////////////////////////////////////////////
// Load up all vars, needed for Inventory UI
////////////////////////////////////////////
// PERSONAL:
// The crateID (even needed? Me (Dscha) later: Yes, consistency between External and Player Inventories!)
private _invData_crateID = AN_data_inventory get "crateID";
if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT:  _invData_crateID", _invData_crateID];};
// grid Data
private _invData_inventory = AN_data_inventory get "inventory";
if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT:  _invData_inventory", _invData_inventory];};
// All Items, currently in the Inventories
private _invData_itemData = AN_data_inventory get "itemData";
if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT:  _invData_itemData", _invData_itemData];};

// Load up the Inventory 
{
	private _invData = _invData_inventory get _x;
	// Do not set the external Inventory! This will be done later!
	if(_x != "1000")then
	{
		[_x, _invData] call an_c_fnc_ui_inv_load;
	};
}forEach (keys _invData_inventory);



////////////////////////////////////////////
// EXTERNAL:
private _dataCrate = createHashmap;
_dataCrate insert _dataCrate_raw;
// diag_log [_dataCrate];

// crateID
private _crate_invData_crateID = _dataCrate get "crateID";
if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT:  _crate_invData_crateID", _crate_invData_crateID];};
// Grid Data
private _crate_invData_inventory_raw = _dataCrate get "inventory";
if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT:  _crate_invData_inventory_raw", _crate_invData_inventory_raw];};
// All Items, currently in the Inventories
private _crate_invData_itemData = _dataCrate get "itemData";
if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT:  _crate_invData_itemData", _crate_invData_itemData];};

// make the external Data a hashmap
_crate_invData_inventory = createHashMap;
{
	_x params ["_invSubID","_invSubData"];
	private _data = createHashMap;
	_data insert _invSubData;
	_crate_invData_inventory set [_invSubID, _data];
}forEach _crate_invData_inventory_raw;

// Load up the Inventory (atm: only "0" - but leaving it as forEach loop, in case we want to add more later!)
{
	private _invData = _crate_invData_inventory get _x;
	[_x, _invData] call an_c_fnc_ui_inv_load;
}forEach (keys _crate_invData_inventory);

////////////////////////////////////////////////////////////////////////////////////////



if(true)exitWith{};
// ToDo: Load Items












///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// Create all Inventories


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External Inventory:


private _dataCrate_crateID = _dataCrate get "crateID";
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: _dataCrate_crateID: %1", _dataCrate_crateID];};

private _dataCrate_inventory_raw = _dataCrate get "inventory";
private _dataCrate_inventory = createHashmap;
_dataCrate_inventory insert _dataCrate_inventory_raw;
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: _dataCrate_inventory: %1", _dataCrate_inventory];};

private _dataCrate_itemData = _dataCrate get "itemData";
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: _dataCrate_itemData: %1", _dataCrate_itemData];};

// Store the ID of the active external Inventory
localNamespace setVariable ["an_inv_external_active",_dataCrate_crateID];
// Load Inventory: External
// ToDo: Pass the invSub ID of the external Inventory, as additional entry!
private _dataCrate_invGridData_raw = _dataCrate_inventory get "0";
private _dataCrate_invGridData = createHashmap;
_dataCrate_invGridData insert _dataCrate_invGridData_raw;

["an_inv_external_grid", true, false, _dataCrate_invGridData, "0", _dataCrate_itemData] call an_c_fnc_ui_inv_load;
if(_DEBUGON)then{diag_log "-----------------------------------------------";};

// [_dataCrate_itemData, false] call an_c_fnc_inv_item_load_data;