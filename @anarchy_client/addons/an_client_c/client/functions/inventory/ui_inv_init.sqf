
  /////////////////////////////////////////////////
 // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////
// reload and update the functions

// Inventory init file
an_c_fnc_ui_inv_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_init.sqf";
an_c_fnc_ui_inv_data_update = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_data_update.sqf";
// Grid
an_c_fnc_ui_inv_grid_check_freeTiles = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_check_freeTiles.sqf";
an_c_fnc_ui_inv_grid_create = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_grid_create.sqf";
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
an_c_fnc_ui_inv_item_data_parent_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_parent_set.sqf";
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
/////////////////////////////////////////////////
private _DEBUGON = false;
// #include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

if!(isNull objectParent player)exitWith{systemchat "DEBUG: Inventory currently blocked, while being in a vehicle!"};
if!(alive player)exitWith{};
params["_dataCrate"];

if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT: DATA:"];};
private _crate_itemData	= ENTRY_GET("itemData",_dataCrate);

if(_DEBUGON)then{diag_log [":::: DEBUG: UI_INV_INIT: ItemData:"];};
if(_DEBUGON)then{{diag_log _x;}forEach _crate_itemData;};

// Check, if inventory is already open. Close it, then reopen it again.
private _disp_preCheck = uiNamespace getVariable ["an_inventory", displayNull];
if !(isNull _disp_preCheck)then{_disp_preCheck closeDisplay 1;};
private _disp = (findDisplay 46) createDisplay "an_inventory";


// Set the names for all available Inventories... 
AN_INVENTORY_LIST =
[
	 ["an_inv_player_area","an_inv_player_grid"]
	,["an_inv_external_area","an_inv_external_grid"]
];
// ...and Slots
AN_SLOTS_LIST =
[
	 ["an_slot_wpn_area","an_slot_wpn_grid"]
	,["an_slot_wpn_area_b","an_slot_wpn_grid_b"]
	,["an_slot_sec_area","an_slot_sec_grid"]
	,["an_slot_uni_area","an_slot_uni_grid"]
	,["an_slot_vst_area","an_slot_vst_grid"]
	,["an_slot_hel_area","an_slot_hel_grid"]
	,["an_slot_bkp_area","an_slot_bkp_grid"]
];
// "Reset" the tileUsage Vars
{
	private _grid = uiNamespace getVariable [(_x#1),controlNull];
	if(!isNull _grid)then
	{
		private _idc = ctrlIDC _grid;
		localNamespace setVariable [(format["an_inv_tileUsage_%1",_idc]),[]];
	};
}forEach (AN_INVENTORY_LIST + AN_SLOTS_LIST);


an_inv_move_placeHorizontal = true;	// init
an_ui_inv_grabActive = false;		// init

////// Create Inventory for Player and Ground
if(_DEBUGON)then{diag_log "-----------------------------------------------";};
// Load Inventory: Player
private _invItemData = localNamespace getVariable ["an_cData_invData",[]];
["an_inv_player_grid", _invItemData] call an_c_fnc_ui_inv_load;

// Change the header Text of the Personal Area, by setting the playername as text
private _ctrlPersonalHeader = uinamespace getvariable ["an_inv_header_personal", controlNull];
_ctrlPersonalHeader ctrlSetText name player;
if(_DEBUGON)then{diag_log "-----------------------------------------------";};

// Store the ID of the active external Inventory
localNamespace setVariable ["an_inv_external_active",ENTRY_GET("crateID",_dataCrate)];
// Load Inventory: External
["an_inv_external_grid", _dataCrate] call an_c_fnc_ui_inv_load;
if(_DEBUGON)then{diag_log "-----------------------------------------------";};

// Change the header Text of the External Area
private _ctrlExternalHeader = uinamespace getvariable ["an_inv_header_external", controlNull];
private _useGround = player getVariable["an_inv_dropActive",false];
if(_useGround)then	{ _ctrlExternalHeader ctrlSetText "Ground"; }
else				{ _ctrlExternalHeader ctrlSetText "Crate"; };


//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// DEV / WIP BELOW
// Set up Gear Slot(-inventories)
if(_DEBUGON)then{diag_log ["------------------------ GEAR ------------------------"];};
private _slotList = [
//   [		VarName, rows, cols, SlotID]
     ["an_slot_wpn_grid",3,6,2]
	,["an_slot_wpn_grid_b",3,6,202]
    ,["an_slot_sec_grid",2,4,3]
    ,["an_slot_uni_grid",6,4,12]
    ,["an_slot_vst_grid",4,4,13]
    ,["an_slot_hel_grid",3,3,10]
    ,["an_slot_bkp_grid",4,4,15]
    // ,["goggles",""]
    // ,["facewear",""]
    // ,["Bino",""]
    // ,["pouch",""]
    // ,["tool",""]
    // ,["w_launch",""]
    // ,["w_main_b",""]
];
private _slottedItems = localNamespace getVariable ["an_cData_invData_slotted",[]];

{
    _x params["_gridName","_slotsRows","_slotsCols","_slotID"];
	
	private _data =
		[
			 ["crateID", getPlayerUID player]
			,["inv_rows", _slotsRows]
		];
	
	private _slotItem = _slottedItems findIf {(_x#0) isEqualTo _slotID};
	if(_slotItem != -1)then
	{
		private _itemData = (_slottedItems#_slotItem)#1;
		private _itemID = ENTRY_GET("id",_itemData);
		
		_data pushback ["itemData",[[_itemID, _itemData]]];
	}
	else
	{
		_data pushback ["itemData",[]];
	};
	
	[_gridName, _data, _slotsCols, _slotID] call an_c_fnc_ui_inv_load;
	
}forEach _slotList;
if(_DEBUGON)then{diag_log ["------------------------ GEAR ------------------------"];};
