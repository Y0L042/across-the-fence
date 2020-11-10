
  /////////////////////////////////////////////////
 // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
/////////////////////////////////////////////////
// reload and update the functions

// Inventory init file
an_c_fnc_ui_inv_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_init.sqf";
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
an_c_fnc_ui_inv_item_remove = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_remove.sqf";
an_c_fnc_ui_inv_item_getClass = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_getClass.sqf";
an_c_fnc_ui_inv_item_data_init = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_init.sqf";
an_c_fnc_ui_inv_item_data_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_set.sqf";
an_c_fnc_ui_inv_item_data_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_get.sqf";
an_c_fnc_ui_inv_item_data_parent_set = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_parent_set.sqf";
an_c_fnc_ui_inv_item_data_parent_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_data_parent_get.sqf";
an_c_fnc_ui_inv_item_slots_usage_get = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slots_usage_get.sqf";
an_c_fnc_ui_inv_item_slots_find_free = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slots_find_free.sqf";
an_c_fnc_ui_inv_item_slots_find_free_check = compile preprocessFileLineNumbers "\sgd\anarchy\an_client_c\client\functions\inventory\ui_inv_item_slots_find_free_check.sqf";
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


an_c_fnc_invKeyHandler =
{
	disableSerialization;
	params ["_ctrl", "_btn", "_btn_shift", "_btn_ctrl", "_btn_alt"];
	if(_btn == 34)then
	{
		[player] call AN_C_fnc_loot_inv_request;
	};
};

if(isNil "an_c_DEV_InventoryKeyEH_ID")then
{
	waitUntil{!isNull findDisplay 46};
	private _disp = findDisplay 46;
	an_c_DEV_InventoryKeyEH_ID = _disp displayAddEventHandler ["keyUp",{call an_c_fnc_invKeyHandler;}];
};

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

// #include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"


params["_dataCrate"];

diag_log [":::: DEBUG: UI_INV_INIT: DATA:"];
private _crate_itemData	= ENTRY_GET("itemData",_dataCrate);

diag_log [":::: DEBUG: UI_INV_INIT: ItemData:"];
{
	diag_log _x;
}forEach _crate_itemData;

// Check, if inventory is already open. Close it, then reopen it again.
private _disp_preCheck = uiNamespace getVariable ["an_inventory", displayNull];
if !(isNull _disp_preCheck)then{_disp_preCheck closeDisplay 1;};
private _disp = (findDisplay 46) createDisplay "an_inventory";

// KeyDown: block every button (movement)
_disp displayAddEventHandler ["keyDown",{if(_this#1 in [1])then{_this#0 closeDisplay 1;}; true}];
// KeyUp: block every button (movement), except ESC/TAB button to close the Inv
_disp displayAddEventHandler ["keyUp",{if(_this#1 in [15])then{_this#0 closeDisplay 1;}; true }];
// Handle scrolling the Mousewheel (only if an item is currently grabbed)
_disp displayAddEventhandler ["MouseZChanged","call an_c_fnc_ui_inv_EH_mouse_z"];

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
diag_log "-----------------------------------------------";
// Load Inventory: Player
private _invItemData = localNamespace getVariable ["an_cData_invData",[]];
["an_inv_player_grid", _invItemData] call an_c_fnc_ui_inv_load;
diag_log "-----------------------------------------------";

// Store the ID of the active external Inventory
localNamespace setVariable ["an_inv_external_active",ENTRY_GET("crateID",_dataCrate)];
// Load Inventory: External
["an_inv_external_grid", _dataCrate] call an_c_fnc_ui_inv_load;
diag_log "-----------------------------------------------";




//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// DEV / WIP BELOW
// Set up Gear Slot(-inventories)
diag_log ["------------------------ GEAR ------------------------"];
private _slotList = [
//   [		VarName, rows, cols, SlotID]
     ["an_slot_wpn_grid",3,6,2]
    ,["an_slot_sec_grid",2,4,3]
    ,["an_slot_uni_grid",6,4,12]
    ,["an_slot_vst_grid",4,4,13]
    ,["an_slot_hel_grid",3,3,10]
    ,["an_slot_bkp_grid",4,4,15]
    // ,["goggles",""]
    // ,["pouch",""]
    // ,["tool",""]
    // ,["w_hand",""]
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
	
	private _slotItem = _slottedItems findIf {(_x#0) isEqualTo _slotID};	// Todo: Making getting and setting a seperate function
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
diag_log ["------------------------ GEAR ------------------------"];
