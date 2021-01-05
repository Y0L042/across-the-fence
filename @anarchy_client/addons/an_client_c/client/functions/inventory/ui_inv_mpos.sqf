private _DEBUGON = false;
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

// _btn used by mPos_check_inInv
params ["_ctrlGrid", "_mPos", "_itemID"];

_mPos params ["_mPosX", "_mPosY"];

private _gridIDC = ctrlIDC _ctrlGrid;
private _invData = AN_data_inventory get "inventory" get str(_gridIDC);
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _invData       :", _invData];};
private _gridRows = _invData get "inv_rows";
private _gridCols = _invData get "inv_cols";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: Grid Rows/Cols :", [_gridRows, _gridCols]];};

if(_gridRows < 0)exitWith
{
	if(_DEBUGON)then{diag_log ["ERROR: UI_INV_MPOS: GRID NOT SET!", _gridIDC, [_gridRows]];};
};


//Check if given pos is valid in the Grid. If so -> Return [y,x] pos in Grid
([_ctrlGrid, _mPosX, _mPosY, _gridRows] call an_c_fnc_ui_inv_grid_posToGrid) params["_tileRow","_tileCol"];
if([_tileRow,_tileCol] isEqualto [-1,-1])exitWith{/* DEV */ private _text = ["gridPos - out of Bounds",[_tileRow, _tileCol]]; diag_log _text; systemchat str _text; };


//Check if DragAndDrop is active. If so -> a suitable pos was found, so we can delete the temp Item, "attached" to the Mouse
if(an_ui_inv_grabActive)then{ an_ui_inv_grabActive = false; };


//////////////////////////////////////////////
private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _parentData    :", _parentData];};
// Check if parentData was found!
if(isNil "_parentData")exitWith{private _text = ["ERROR: UI_INV_MPOS: _parentData NOT FOUND: Class:", _itemData]; diag_log _text; systemchat str _text;};

// Get all the needed Data from the parent
private _parentSize = _parentData get "baseData" get "size";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _parentSize    :", _parentSize];};
private _parentSlot = _parentData get "baseData" get "slot";
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _parentSlot    :", _parentSlot];};


// Check if targeted Grid is a Slot and it is allowed to be placed in there
private _isSlot = _invData get "isSlot";
private _slotID = _invData get "invID";

_slotValidCheck = true;
if(_isSlot == 1)then
{
	if!(_slotID in _parentSlot)exitWith{_slotValidCheck = false;};
	// if it's a slot -> reset the Row/Col to [0,0] (always top left slot first!)
	_tileRow = 0;
	_tileCol = 0;
};
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _tileRow/Col   :", [_tileRow, _tileCol]];};
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _slotValidCheck:", _slotValidCheck];};

private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_space_usage_get;
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _itemSlotUsage : ",_itemSlotUsage];};

//_tiles_used == taken positions in Grid, needed to free up the needed Slots later
private _offsetPos = [[_tileRow, _tileCol]];	//store first Pos (needed, since the offset will determined from this position)
{
	_x params["_posRow","_posCol"];
	if(an_inv_move_placeHorizontal)then
	{
		_offsetPos pushbackUnique [ (_tileRow + _posRow), (_tileCol + _posCol) ];
	}else{
		_offsetPos pushbackUnique [ (_tileRow + _posCol), (_tileCol + _posRow) ];
	};
}forEach _itemSlotUsage;
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _offsetPos     : ",_offsetPos];};

//Check if all tiles are free
//get used slots from grid
private _gridUsedSlots = [str(_gridIDC)] call an_c_fnc_ui_inv_grid_tiles_used_get;
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _gridUsedSlots : ",_gridUsedSlots];};

// Check if tiles in the targeted Grid are free. If not -> Return empty Array and trigger a "re-add" to the old position
// if free -> Return the used Tiles
private _itemTileUsage = [_ctrlGrid,_gridRows,_offsetPos,_gridUsedSlots] call an_c_fnc_ui_inv_grid_check_freeTiles;
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _itemTileUsage : ",_itemTileUsage];};

// Check if its a failed attemp
if(_itemTileUsage isEqualto [] || !_slotValidCheck)then
{
	if(!_slotValidCheck)then{systemchat "Can't be placed in that Slot";}
	else					{systemchat "Slot is already occupied";};
	// if failed attemp -> readd the Item and its used slots in its previously used grid
	
	private _ctrl = uinamespace getVariable ["an_ctrl_active",controlNull];
	if(isNull _ctrl)exitWith{systemchat "ERROR: UI_INV_MPOS: (isNull _ctrl)";};
	
	private _itemID = _ctrl getVariable "itemID";
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _itemID        : ",_itemID];};
	private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _itemData      : ",_itemData];};
	private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _parentData    : ",_parentData];};
	private _itemPosPrev = _itemData get "invPos";
	if(_DEBUGON)then{diag_log ["DEBUG: EH_MouseBTN: _itemPosPrev   : ",_itemPosPrev];};
	
	private _invPrev = _itemData get "invSub";
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _invPrev       : ",_invPrev];};
	_invDataPrev = AN_data_inventory get "inventory" get _invPrev;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _invDataPrev   : ",_invDataPrev];};
	private _ctrlInvGrid = uinamespace getVariable [(_invDataPrev get "invGrid"), controlNull];
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: _ctrlInvGrid   : ",_ctrlInvGrid];};
	
	([_invDataPrev, _itemPosPrev] call an_c_fnc_ui_inv_grid_gridToPos)params["_itemGridPosRow", "_itemGridPosCol"];
	// create it again
	[_ctrlInvGrid,_itemGridPosRow,_itemGridPosCol,_itemID] call an_c_fnc_ui_inv_item_create;
}
else
{
	// If everything was fine, add the Item to the selected grid
	// add all tiles to the "slotsUsed"-array and update the hashmap invData
	[_gridUsedSlots,_itemTileUsage] call an_c_fnc_ui_inv_grid_tiles_used_update;
	
	// get the grid pos of the first entry (TopLeft Slot)
	private _invPos_new = _itemTileUsage#0;
	([_invData, _invPos_new] call an_c_fnc_ui_inv_grid_gridToPos)params["_itemGridPosRow", "_itemGridPosCol"];
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: gridToPos      : ",[_itemGridPosRow, _itemGridPosCol]];};

	
	// add the Item to the passed position
	[ _ctrlGrid, _itemGridPosRow, _itemGridPosCol, _itemID] call an_c_fnc_ui_inv_item_create;
	
	
	private _itemInvID_cur = _itemData get "curInv";
	private _invPos_cur = _itemData get "invPos";
	private _invSubCur = _itemData get "invSub";
	
	private _invSubID_new = _invData get "invID";
	private _itemInvID_new = AN_data_inventory get "inventory" get _invSubID_new get "crateID";
	
	private _isFlipped = _itemData get "isFlipped";
	
	
	_sameInv = _itemInvID_cur isEqualto _itemInvID_new;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: MOVING ID      : ",_itemInvID_cur, _itemInvID_new];};
	_sameSub = _invSubCur isEqualto _invSubID_new;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: MOVING subID   : ",_invSubCur, _invSubID_new];};
	_sameSpot = _invPos_cur isEqualto _invPos_new;
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: MOVING invPos  : ",_invPos_cur, _invPos_new];};
	
	if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: MOVING ITEM    : ",(!_sameInv || !_sameSpot || !_sameSub)];};
	if(!_sameInv || !_sameSpot || !_sameSub)then
	{
		private _data = [_itemID ,_itemInvID_cur ,_invSubCur ,_itemInvID_new ,_invSubID_new ,_invPos_new ,_isFlipped];
		if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_MPOS: ITEM_MOVE DATA : ",_data];};
		// Send an update-request to the Backend.
		["item_move", _data] call AN_G_fnc_msg_send;
		
		// Updating the Item:
		_itemData set ["curInv", _itemInvID_new];
		_itemData set ["invPos", _invPos_new];
		_itemData set ["invSub", _invSubID_new];
		_itemData set ["isFlipped", _isFlipped];
		
		// Update "itemData"
		[_itemInvID_new, _itemData, _itemID] call an_c_fnc_ui_inv_data_update;
	};
	
};


