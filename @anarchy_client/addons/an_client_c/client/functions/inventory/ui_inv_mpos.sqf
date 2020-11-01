
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

// _btn used by mPos_check_inInv
params ["_ctrlGrid", "_btn", "_mPos", ["_btnShift",false,[false]], ["_btnCtrl",false,[false]], ["_btnAlt",false,[false]]];

_mPos params ["_mPosX", "_mPosY"];

private _gridIDC = ctrlIDC _ctrlGrid;
_gridSize = localNamespace getVariable [format["an_inv_grid_size_%1",_gridIDC],[-1,-1]];
_gridSize params ["_gridRows","_gridCols"];
if(_gridRows isEqualto [-1,-1])exitWith
{
	diag_log ["ERROR: UI_INV_MPOS: GRID NOT SET!", _gridIDC, [_gridRows]];
};


//Check if given pos is valid in the Grid. If so -> Return [y,x] pos in Grid
([_ctrlGrid,_mPosX,_mPosY,_gridRows] call an_c_fnc_ui_inv_grid_posToGrid) params["_tileRow","_tileCol"];
if([_tileRow,_tileCol] isEqualto [-1,-1])exitWith{/* DEV */ systemchat str["gridPos - out of Bounds",[_tileRow, _tileCol]];};


//Check if DragAndDrop is active. If so -> a suitable pos was found, so we can delete the temp Item, "attached" to the Mouse
if(an_ui_inv_grabActive)then{ an_ui_inv_grabActive = false; };


//////////////////////////////////////////////
private _itemClass = [] call an_c_fnc_ui_inv_item_active_class_get;
private _parentData = [_itemClass] call an_c_fnc_ui_inv_item_data_parent_get;
// diag_log ["DEBUG: UI_INV_MPOS: _parentData   :", _parentData];
// Check if parentData was found!
diag_log str ["_parentData", _parentData];
if(_parentData isEqualto [])exitWith{private _text = ["ERROR: UI_INV_MPOS: _parentData NOT FOUND: Class:", _itemClass]; diag_log _text; systemchat str _text;};

// Get all the needed Data from the parent
private _parentSize = ENTRY_GET("size",_parentData);
// diag_log ["DEBUG: UI_INV_MPOS: _parentSize   :", _parentSize];
private _parentSlot = ENTRY_GET("slot",_parentData);
diag_log ["DEBUG: UI_INV_MPOS: _parentSlot   :", _parentSlot];


// Check if targeted Grid is a Slot and it is allowed to be placed in there
_slotID = _ctrlGrid getVariable ["slotID", 0];
// systemchat str [_parentSlot, _slotID];

_slotValidCheck = true;
// Check if it's 
if(_slotID > 0)then
{
	// Check if Item can be placed in this Slot
	if(_parentSlot != _slotID)exitWith{_slotValidCheck = false;};
	// systemchat str["SLOT CHECK PASSED - Reseting ROW/COL - _itemClass: ", _itemClass];
	// if -> reset the Row/Col to [0,0]
	_tileRow = 0;
	_tileCol = 0;
};

if(!_slotValidCheck)exitWith{systemchat "Can't be placed in that Slot";};

private _itemSlotUsage = [_parentSize] call an_c_fnc_ui_inv_item_slots_usage_get;

//_tiles_used == taken positions in Grid, needed to free up the needed Slots later
private _offsetPos = [[_tileRow, _tileCol]];	//store first Pos (needed, since the offset will determined from this position)
{
	_x params["_posRow","_posCol"];
	if(an_inv_move_placeHorizontal)then
	{
		_offsetPos pushbackUnique [ (_tileRow + _posRow), (_tileCol - (_posCol*-1)) ];
	}else{
		_offsetPos pushbackUnique [ (_tileRow + _posCol), (_tileCol + _posRow) ];
	};
}forEach _itemSlotUsage;


//Check if all tiles are free
//get used slots from grid
private _gridTilesUsed = [_gridIDC] call an_c_fnc_ui_inv_grid_tiles_used_get;
// diag_log["------- _gridTilesUsed: ",_gridTilesUsed];

// Check if tiles in the targeted Grid are free. If not -> Return empty Array and trigger a "re-add" to the old position
// if free -> Return the used Tiles
private _itemTileUsage = [_ctrlGrid,_gridRows,_offsetPos,_gridTilesUsed] call an_c_fnc_ui_inv_grid_check_freeTiles;
// diag_log["------- _itemTileUsage: ",_itemTileUsage];

// Check if its a failed attemp
if!(_itemTileUsage isEqualto [])then
{
	// add all tiles to the "blocked tiles"-array and store it in the Grid-parent itself
	[_ctrlGrid,_gridTilesUsed,_itemTileUsage] call an_c_fnc_ui_inv_grid_tiles_used_update;
	
	// get the grid pos of the first entry (TopLeft Slot)
	([_ctrlGrid, _gridRows, _itemTileUsage#0] call an_c_fnc_ui_inv_grid_gridToPos)params["_itemGridPosRow", "_itemGridPosCol"];
	
	// add the Item to the passed position
	[_ctrlGrid,_itemGridPosRow,_itemGridPosCol,_itemClass,_offsetPos] call an_c_fnc_ui_inv_item_create;
	
}
else
{
	// if failed attemp -> readd the Item and its used slots in its previously used grid
	private _ctrl = uinamespace getVariable ["an_ctrl_active",controlNull];
	if(isNull _ctrl)exitWith{systemchat "ERROR: mPos: (isNull _ctrl)";};
	
	private _dataPrev = _ctrl getVariable ["item_data_prev",[]];
	if(_dataPrev isEqualto [])exitWith{systemchat "ERROR: mPos: (_dataPrev isEqualto [])";};
	
	// Get the previous data
	_dataPrev params ["_ctrlParentPrev","_pX","_pY","_itemClass","_itemUsedSlotsPrev","_posData"];
	
	private _gridTilesUsedCur = [(ctrlIDC _ctrlParentPrev)] call an_c_fnc_ui_inv_grid_tiles_used_get;
	
	// add all tiles to the "blocked tiles"-array and store it in the Grid-parent itself
	[_ctrlParentPrev,_gridTilesUsedCur,_itemUsedSlotsPrev] call an_c_fnc_ui_inv_grid_tiles_used_update;
	
	// create it again
	_dataPrev call an_c_fnc_ui_inv_item_create;
};


