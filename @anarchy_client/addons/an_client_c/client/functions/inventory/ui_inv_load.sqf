private _DEBUGON = false;
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"


params["_gridName", "_isExternal", "_isSlot", "_invGridData", ["_subGridID","0",[""]], ["_slotID",0,[0]], ["_itemData",[],[[]]]];


if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Inventory: %1", _gridName];};

// create the grid
private _gridRows = ENTRY_GET("inv_rows",_invGridData);
private _gridCols = ENTRY_GET("inv_cols",_invGridData);
private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];

if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Ctrl: %1", _ctrlGrid];};
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Rows, Cols: %1", [_gridRows,_gridCols]];};

// Store the gridname, so we can access it later easily
_ctrlGrid setVariable ["gridName", _gridName];
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Is External: %1", _isExternal];};
if(_isExternal)then
{
	_ctrlGrid setVariable ["gridAutoTgt",""];
}else{
	_ctrlGrid setVariable ["gridAutoTgt","an_inv_external_grid"];
};
// Set the slotID (0 = Player and External Inventories || Everything > 0 == Slot)
_ctrlGrid setVariable ["slotID", _slotID];
_ctrlGrid setVariable ["rows", _gridRows];
_ctrlGrid setVariable ["cols", _gridCols];

// set the Var for the EXTERNAL grid and show the "grid images"
[_ctrlGrid, _gridName] call an_c_fnc_ui_inv_grid_create;

if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Inventory: %1 - DONE", _gridName];};



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ToDo: Move to seperate function!
// add the Items:
private _DEBUGON = false;

if(_DEBUGON)then{diag_log format["- DEBUG: Loading Items: %1", _itemData];};

{
	_x params ["_x_itemId","_x_itemData"];
	if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item Data : %1", _x_itemData];};
	
	private _itemInvSub = ENTRY_GET("invSub",_x_itemData);
	if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item InventorySub: %1", _itemInvSub];};
	
	// if(_itemInvSub isEqualTo _subGridID)then
	// {
		localNamespace setVariable [_x_itemId, _x_itemData];
		if(_DEBUGON)then{diag_log ["- DEBUG: LNS DATA: ", localNamespace getVariable [_x_itemId,"NONE"]];};
		
		private _itemSlotID = ENTRY_GET("inSlot",_x_itemData);
		if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item _itemSlotID: %1", _itemSlotID];};
		// get the parent class
		private _itemClass = ENTRY_GET("parent",_x_itemData);
		if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item _itemClass: %1", _itemClass];};
		
		// get the pos, this item was stored in
		private _itemPos = ENTRY_GET("invPos",_x_itemData);
		//convert from gridPos to uiPos
		([_ctrlGrid, _itemPos ]call an_c_fnc_ui_inv_grid_gridToPos) params["_itemPosY","_itemPosX"];
		if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item X/Y: %1", [_itemPosY, _itemPosX]];};
		
		
		// check if the Item is in a slot. If so, do NOT add it to the normal Inventory screen (ToDo: Assign to corresponding "slot control")
		if(_itemSlotID == 0)then
		{
			// set the ID and Classname, to create the Item
			[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
			[_x_itemId] call an_c_fnc_ui_inv_item_active_id_set;
			
			[_ctrlGrid,0,[_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;
		}
		else
		{
			// Only add the slotted Item, when the correct grid (the corresponding Slot-grid, related to the SlotID) is passed
			if(_isSlot)then
			{
				
				// set the ID and Classname, to create the Item
				[_itemClass] call an_c_fnc_ui_inv_item_active_class_set;
				[_x_itemId] call an_c_fnc_ui_inv_item_active_id_set;
				
				[_ctrlGrid,0,[_itemPosY,_itemPosX]] call an_c_fnc_ui_inv_mPos;
			};
		};
		if(_DEBUGON)then{diag_log "-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-";};
	// };
}forEach _itemData;