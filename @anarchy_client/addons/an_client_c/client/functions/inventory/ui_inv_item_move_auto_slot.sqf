/*
	Auto move the Item the correct Equipment Slot (Ctrl+LMB on an Item)
*/

params ["_ctrl"];

private _itemID = _ctrl getVariable ["itemID",""];
if(_itemID isEqualTo "")exitWith{systemchat "ERROR: ITEM_MOVE_AUTO: ITEM ID NOT FOUND";};
// Get the Item Data:
private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
private _itemInvID_cur = _itemData get "invSub";
private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
private _parentSize = _parentData get "baseData" get "size";
private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_space_usage_get;

// Check if the Item is already in a slot:
_itemSlotIDList = _parentData get "baseData" get "slot";
// Check if the Item can be slotted. If it has "1000" in it -> It can't be slotted anywhere!
if("1000" in _itemSlotIDList)exitWith{};
// First entry will always be the primary Equip Slot
if(_itemInvID_cur isEqualTo (_itemSlotIDList#0))exitWith{systemchat "DEV: Item already in it's Slot!";};


// Prepare the Data we need for "inv_mPos"
private _invSubIDCur = str(ctrlIDC ctrlParentControlsGroup _ctrl);
private _itemPosY = -1;
private _itemPosX = -1;
private _ctrlGrid_new = controlNull;


// get the slot invData:
// Note: Since some Items (for example "primary weapons") can have multiple Slots, we do an forEach and check all them.
private _slotsFound = false;
{
	_slotID = _x;
	private _invData = AN_data_inventory get "inventory" get _slotID;
	private _gridUsedSlots = _invData get "slotsUsed";
	// Check if Slot has already something in it
	// Note: Slots are basically Inventories, but can have max one Item in it! So if there are Slots taken -> Something is already equipped in there.
	if(_gridUsedSlots isEqualTo [])exitWith
	{
		_slotsFound = true;
		
		// Nothing in that slot? Okay, let's prepare the rest for "inv_mPos".
		_ctrlGrid_new = uinamespace getvariable [(_invData get "invGrid"), controlNull];
		
		// Slotted Items will ALWAYS be in position [0,0]
		private _itemPosNew = [_invData, [0,0] ]call an_c_fnc_ui_inv_grid_gridToPos;
		_itemPosY = _itemPosNew#0;
		_itemPosX = _itemPosNew#1;
	};
}forEach _itemSlotIDList;

// If nothing was found, _itemPosY is still -1, so exit here (no free slots found)
if(!_slotsFound)exitWith{systemchat "NO FREE SLOTS FOUND!";};

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

[_ctrlGrid_new, [_itemPosY,_itemPosX], _itemID] call an_c_fnc_ui_inv_mPos;

_ctrl spawn {ctrlDelete _this;};






