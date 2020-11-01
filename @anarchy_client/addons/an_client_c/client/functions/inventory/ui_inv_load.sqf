
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params["_gridName", "_invData", ["_gridCols",8], ["_slotID",0]];
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Inventory: ...",_gridName];

// create the grid
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: grid: ...",_gridName];
private _InvDataGridRows = ENTRY_GET("inv_rows",_invData);
private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];
// Set the slotID (0 = Player and External Inv - everything > 0 == Slot)
_ctrlGrid setVariable ["slotID", _slotID];

// set the Col size in the grid itself, so we can request it later again (Slots = different Col count)
// Must be set BEFORE grid_create is being called.
// _ctrlGrid setVariable ["an_sizeCol", _gridCols];		// ToDo: an_sizeCol - Recheck if needed.

// set the Var for the EXTERNAL grid and show the "grid images"
[_ctrlGrid, [_InvDataGridRows, _gridCols], _gridName, _slotID] call an_c_fnc_ui_inv_grid_create;
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: grid : ... done",_gridName];

// add the Items:
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Items: ...",_gridName];
private _items = ENTRY_GET("itemData",_invData);

diag_log "-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-";
{
	_x params ["_itemId","_itemData"];
	// diag_log ["DEBUG: UI_INV_INIT: _itemData     :",_itemData];
	
	localNamespace setVariable [_itemId, _itemData];
	diag_log ["DEBUG: LNS DATA: ", localNamespace getVariable [_itemId,"NONE"]];
	
	private _itemSlotID = ENTRY_GET("inSlot",_itemData);
	// get the parent class
	private _itemClass = ENTRY_GET("parent",_itemData);
	
	// get the pos, this item was stored in
	private _itemPos = ENTRY_GET("invPos",_itemData);
	//convert from gridPos to uiPos
	([_ctrlGrid, _InvDataGridRows, _itemPos ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];
	
	//DEBUG
	// diag_log ["DEBUG: UI_INV_INIT: _itemClass    :", _itemClass];
	// diag_log ["DEBUG: UI_INV_INIT: _itemPos      :", _itemPos];
		
	// check if the Item is in a slot. If so, do NOT add it to the normal Inventory screen (ToDo: Assign to corresponding "slot control")
	if(_itemSlotID == 0)then
	{
		// set the ID and Classname, to create the Item
		[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
		[_itemId] call an_c_fnc_ui_inv_item_active_id_set;
		
		[_ctrlGrid,0,[_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;
		diag_log "-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-";
	}
	else
	{
		// ToDo: check if the Slot is already in use!
		// Only add the slotted Item, when the correct grid (the corresponding Slot-grid, related to the SlotID) is passed
		if !(_gridName in ["an_inv_player_grid","an_inv_external_grid"])then
		{
			// diag_log format["DEBUG: UI_INV_INIT: _gridName == %1",_gridName];
			// diag_log [_itemSlotID, _ctrlGrid, _itemClass, _itemData];
			
			// set the ID and Classname, to create the Item
			[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
			[_itemId] call an_c_fnc_ui_inv_item_active_id_set;
			
			[_ctrlGrid,0,[_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;
		};
	};
}forEach _items;
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Items: ... done",_gridName];
diag_log format["DEBUG: UI_INV_INIT: %1 - setting up: Inventory: ... done",_gridName];