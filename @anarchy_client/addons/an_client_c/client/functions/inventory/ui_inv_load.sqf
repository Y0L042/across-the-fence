
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params["_disp", "_gridName", "_inv_Data"];
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Inventory: ...",_gridName];

// create the grid
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: grid: ...",_gridName];
private _grid_rows = ENTRY_GET("inv_rows",_inv_Data);
private _ctrl_inventory = uinamespace getvariable [_gridName, controlNull];
// set the Var for the EXTERNAL grid and show the "grid images"
[_disp,_ctrl_inventory,_grid_rows] call an_c_fnc_ui_inv_grid_create;
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: grid : ... done",_gridName];

// add the Items:
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Items: ...",_gridName];
private _items = ENTRY_GET("itemData",_inv_Data);

diag_log "-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-";
{
	_x params ["_item_id","_item_data"];
	diag_log ["DEBUG: UI_INV_INIT: _item_data     :",_item_data];
	
	localNamespace setVariable [_item_id, _item_data];
	diag_log ["DEBUG: LNS DATA: ", localNamespace getVariable [_item_id,"NONE"]];
	
	// get the parent class
	private _item_class = ENTRY_GET("parent",_item_data);
	
	// get the pos, this item was stored in
	private _item_pos = ENTRY_GET("invPos",_item_data);
	//convert from gridPos to uiPos
	([_ctrl_inventory, _grid_rows, _item_pos ]call an_c_fnc_ui_inv_grid_gridToPos) params["_item_pos_y","_item_pos_x"];
	
	//DEBUG
	diag_log ["DEBUG: UI_INV_INIT: _item_class    :", _item_class];
	diag_log ["DEBUG: UI_INV_INIT: _item_pos      :", _item_pos];
	
	// set the ID and Classname, to create the Item
	[_item_class] call an_c_fnc_ui_inv_item_active_class_set;
	[_item_id] call an_c_fnc_ui_inv_item_active_id_set;
	
	[_ctrl_inventory,0,[_item_pos_y,_item_pos_x]] call an_c_fnc_ui_inv_mPos;
	diag_log "-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-";
}forEach _items;
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Items: ... done",_gridName];
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Inventory: ... done",_gridName];