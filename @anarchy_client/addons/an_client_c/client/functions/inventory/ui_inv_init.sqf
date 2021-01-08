
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
an_c_fnc_ui_inv_grid_tiles_used_remove = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_tiles_used_remove.sqf";
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
an_c_fnc_ui_inv_item_move_auto_slot = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_move_auto_slot.sqf";
an_c_fnc_ui_inv_item_drop_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_drop_check.sqf";
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
			// Inventories:
			// (Reserved IDC Range = 1000-1999)
			 ["1013",[ ["inv_rows",5],	["inv_cols",8]], ["invID",1013],	["invGrid","an_inv_vst_grid"],		["invArea","an_inv_vst_area"],		]
			,["1012",[ ["inv_rows",16],	["inv_cols",8]], ["invID",1012],	["invGrid","an_inv_uni_grid"],		["invArea","an_inv_uni_area"]		]
			,["1015",[ ["inv_rows",7],	["inv_cols",8]], ["invID",1015],	["invGrid","an_inv_bkp_grid"],		["invArea","an_inv_bkp_area"]		]
			,["1014",[ ["inv_rows",6],	["inv_cols",8]], ["invID",1014],	["invGrid","an_inv_pch_grid"],		["invArea","an_inv_pch_area"]		]
			// Slots:
			// (Reserved IDC Range = 2000-2999)
			,["2002",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2002],	["invGrid","an_slot_wpn_grid"],		["invArea","an_slot_wpn_area"]		]
			,["2202",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2202],	["invGrid","an_slot_wpn_b_grid"],	["invArea","an_slot_wpn_b_area"]	]
			,["2003",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2003],	["invGrid","an_slot_sec_grid"],		["invArea","an_slot_sec_area"]		]
			,["2010",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2010],	["invGrid","an_slot_hel_grid"],		["invArea","an_slot_hel_area"]		]
			,["2011",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2011],	["invGrid","an_slot_gog_grid"],		["invArea","an_slot_gog_area"]		]
			,["2012",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2012],	["invGrid","an_slot_uni_grid"],		["invArea","an_slot_uni_area"]		]
			,["2013",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2013],	["invGrid","an_slot_vst_grid"],		["invArea","an_slot_vst_area"]		]
			,["2015",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2015],	["invGrid","an_slot_bkp_grid"],		["invArea","an_slot_bkp_area"]		]
			,["2017",[ ["inv_rows",8],	["inv_cols",8]], ["invID",2017],	["invGrid","an_slot_bin_grid"],		["invArea","an_slot_bin_area"]		]
		]
	,"itemData",
		[
			 TODO: UPDATE NEEDED
		]
];
*/



private _DEBUGON = false;
// #include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"
// #include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

if!(isNull objectParent player)exitWith{systemchat "DEBUG: Inventory currently blocked, while being in a vehicle!"};
if!(alive player)exitWith{};

params["_dataCrate_raw"];
private _DEBUG_TimeStart = diag_tickTime;
an_inv_move_placeHorizontal = true;	// init
an_ui_inv_grabActive = false;		// init

////////////////////////////////////////////////////////////////////////////////////////
// Check, if inventory is already open. Close it, then reopen it again.
private _disp_preCheck = uiNamespace getVariable ["an_inventory", displayNull];
if !(isNull _disp_preCheck)then{_disp_preCheck closeDisplay 1;};
private _disp = (findDisplay 46) createDisplay "an_inventory";

// Disable ActionMenu (ScrollWheelMenu)
inGameUISetEventHandler ["PrevAction", "true"];
inGameUISetEventHandler ["NextAction", "true"];
inGameUISetEventHandler ["Action", "true"];

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
////////////////////////////////////////////////////////////////////////////////////////

// PERSONAL:
if(_DEBUGON)then{diag_log "--------------------------------";};
if(_DEBUGON)then{diag_log "----------- PERSONAL -----------";};
if(_DEBUGON)then{diag_log "--------------------------------";};

// The crateID (even needed? Me (Dscha) later: Yes, consistency between External and Player Inventories!)
private _invData_crateID = AN_data_inventory get "crateID";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT:  _invData_crateID", _invData_crateID];};
// grid data
private _invData_inventory = AN_data_inventory get "inventory";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT:  _invData_inventory", _invData_inventory];};
// Load up and create the items in the PLAYER-inventories:
private _invData_itemData = AN_data_inventory get "itemData";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT:  _invData_itemData", _invData_itemData];};

// Reset the autoTarget data (will be rebuild by inv_load)
AN_data_inventory set ["invAutoTarget",[]];


// Load up the Inventory 
{
	private _invData = _invData_inventory get _x;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT:  _invData_inventory ID - ", _x];};
	// Do not set the "external" Inventory! This will be done later!
	if(_x != "1000")then
	{
		[_invData, _x] call an_c_fnc_ui_inv_load;
		if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT:  _invData_inventory ID - ",_x, " - loaded"];};
	};
}forEach (keys _invData_inventory);


{
	// diag_log "--------------------------------";
	private _itemData = [_x] call an_c_fnc_ui_inv_item_data_get;
	// diag_log ["DEBUG: UI_INV_INIT: ITEM: _itemData    :", _itemData];
	private _itemSlotCur = _itemData get "invSub";
	private _invData = AN_data_inventory get "inventory" get _itemSlotCur;
	// diag_log ["DEBUG: UI_INV_INIT: ITEM: _itemSlotCur : ", _itemSlotCur];
	// diag_log ["DEBUG: UI_INV_INIT: ITEM: _invData     : ", _invData];
	
	private _itemPos = _itemData get "invPos";
	private _gridName = _invData get "invGrid";
	
	private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];
	([_invData, _itemPos ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];
	// diag_log ["DEBUG: UI_INV_INIT: ITEM: itemPos      : ", [_itemPosY, _itemPosX]];
	
	[_ctrlGrid, [_itemPosY,_itemPosX], (_itemData get "id")] call an_c_fnc_ui_inv_mPos;
}foreach (keys _invData_itemData);


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

// EXTERNAL:
if(_DEBUGON)then{diag_log "--------------------------------";};
if(_DEBUGON)then{diag_log "----------- EXTERNAL -----------";};
if(_DEBUGON)then{diag_log "--------------------------------";};

private _dataCrate = createHashmap;
_dataCrate insert _dataCrate_raw;

// crateID
private _crate_invData_crateID = _dataCrate get "crateID";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: _crate_invData_crateID       :", _crate_invData_crateID];};
// grid data
private _crate_invData_inventory_raw = _dataCrate get "inventory";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: _crate_invData_inventory_raw :", _crate_invData_inventory_raw];};
// Load up and create the items in the EXTERNAL-inventories:
private _crate_invData_itemData_raw = _dataCrate get "itemData";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: _crate_invData_itemData_raw  :", _crate_invData_itemData_raw];};


// make the external Data a hashmap and update the external Data (atm only "1000").
_crate_invData_inventory = createHashMap;
{
	_x params ["_invSubID","_invSubData"];
	private _invData = createHashMap;
	_invData insert _invSubData;
	AN_data_inventory get "inventory" set [_invSubID, _invData];
	
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: _invData     :", _invData];};
	[_invData] call an_c_fnc_ui_inv_load;
}forEach _crate_invData_inventory_raw;

if(_DEBUGON)then{diag_log "--------------------------------";};

// Load up the "external" Items - Those Items will ALWAYS get overwritten and newly requested, when opening the Inventory!
AN_data_items_ext = createHashMap;
{
	_x params ["_itemID","_itemData_raw"];
	private _itemData = createHashMap;
	_itemData insert _itemData_raw;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: ITEM: ", _itemData];};
	AN_data_items_ext set [_itemID, _itemData];
}forEach _crate_invData_itemData_raw;

// load in the items:
{
	if(_DEBUGON)then{diag_log "--------------------------------";};
	private _itemData = [_x] call an_c_fnc_ui_inv_item_data_get;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: ITEM: _itemData    :", _itemData];};
	private _itemSlotCur = _itemData get "invSub";
	private _invData = AN_data_inventory get "inventory" get _itemSlotCur;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: ITEM: _itemSlotCur : ", _itemSlotCur];};
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: ITEM: _invData     : ", _invData];};
	
	private _itemPos = _itemData get "invPos";
	private _gridName = _invData get "invGrid";
	
	private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];
	([_invData, _itemPos ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_INIT: ITEM: itemPos      : ", [_itemPosY, _itemPosX]];};
	
	[_ctrlGrid, [_itemPosY,_itemPosX], (_itemData get "id")] call an_c_fnc_ui_inv_mPos;
}foreach AN_data_items_ext;

private _DEBUG_TimeEnd = diag_tickTime;
diag_log format["DEBUG: UI_INV_INIT LOADED in %1s - creating: %2 Inventory Items",((_DEBUG_TimeEnd - _DEBUG_TimeStart) toFixed 9), ((count AN_data_items_ext)+(count _invData_itemData))];

if(_DEBUGON)then{diag_log "--------------------------------";};
if(_DEBUGON)then{diag_log "--------------------------------";};

// Sort the Inventories, so the order to auto-place items would be:
// Uniform > Vest > Pouch > Backpack
(AN_data_inventory get "invAutoTarget") sort true;