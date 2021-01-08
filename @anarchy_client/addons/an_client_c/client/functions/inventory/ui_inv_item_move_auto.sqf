/*
	Auto move the Item the opposite Inventory (Shift+LMB on an Item)
*/

params ["_ctrl"];

private _itemID = _ctrl getVariable ["itemID",""];
if(_itemID isEqualTo "")exitWith{systemchat "ERROR: ITEM_MOVE_AUTO: ITEM ID NOT FOUND";};
// Get the Item Data:
private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
private _parentSize = _parentData get "baseData" get "size";
private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_space_usage_get;

// Prepare the Data we need for "inv_mPos"
private _invSubIDCur = str(ctrlIDC ctrlParentControlsGroup _ctrl);
private _itemPosY = -1;
private _itemPosX = -1;
private _ctrlGrid = controlNull;
// If Item is in External Inventory -> get a player Inventory, otherwise... erm, get the external?
private _activeInvList = if (_invSubIDCur isEqualTo "1000")then	{ AN_data_inventory get "invAutoTarget_inv" }
else															{ ["1000"] };

private _itemPos = [-1,-1];
{
	_invSubIDNew = _x;
	private _invData = AN_data_inventory get "inventory" get _invSubIDNew;
	private _gridName = _invData get "invGrid";
	_ctrlGrid = uinamespace getvariable [_gridName, controlNull];	// DO NOT "PRIVATE"

	private _rowMax = (_invData get "inv_rows") - _parentSize#0;
	private _colMax = (_invData get "inv_cols") - _parentSize#1;

	private _gridUsedSlots = _invData get "slotsUsed";

	// !! Recursive function, to find a suitable spot in the Inventory !!
	_slotsUsed_new = [_rowMax, _colMax, _itemSlotUsage, _gridUsedSlots] call an_c_fnc_ui_inv_item_space_find_free;
	
	// Exit if free slots WERE found
	if!(_slotsUsed_new isEqualTo [])exitWith
	{
		// first position (topLeft) == invPos of the Item.
		_itemPos = _slotsUsed_new#0;
		_itemPosNew = [_invData, _itemPos ]call an_c_fnc_ui_inv_grid_gridToPos;
		_itemPosY = _itemPosNew#0;
		_itemPosX = _itemPosNew#1;
	};
}forEach _activeInvList;


// If nothing was found, _itemPosY is still -1, so exit here (no free slots found)
if(_itemPos isEqualTo [-1,-1])exitWith{systemchat "NO FREE SLOTS FOUND!";};

/////////////////////////////////////////////////////////////////
// !! REMOVE PREVIOUSLY USED SLOTS FROM CURRENT GRID BEFORE CALLING "INV_MPOS" !!
(_itemData get "invPos") params ["_tileRow","_tileCol"];
private _isFlipped = _itemData get "isFlipped";
private _offsetPos = [[_tileRow, _tileCol]];	//store first Pos (needed, since the offset will determined from this position)
{
	_x params["_posRow","_posCol"];
	if(_isFlipped == 0)then
	{
		_offsetPos pushbackUnique [ (_tileRow + _posRow), (_tileCol + _posCol) ];
	}else{
		_offsetPos pushbackUnique [ (_tileRow + _posCol), (_tileCol + _posRow) ];
	};
}forEach _itemSlotUsage;

// Remove the currently used slots, so it can be placed at the same Slots it has used before:
[_invSubIDCur, _offsetPos] call an_c_fnc_ui_inv_grid_tiles_used_remove;
// !! REMOVE PREVIOUSLY USED SLOTS FROM CURRENT GRID !!
/////////////////////////////////////////////////////////////////


[_ctrlGrid, [_itemPosY,_itemPosX], _itemID] call an_c_fnc_ui_inv_mPos;

_ctrl spawn {ctrlDelete _this;};


