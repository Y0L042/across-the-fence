
private _DEBUGON = false;
params["_invData"];

private _gridName = _invData get "invGrid";
private _areaName = _invData get "invArea";
private _gridRows = _invData get "inv_rows";
private _gridCols = _invData get "inv_cols";
private _invID = _invData get "invID";		// gridID == IDC == entry inside (AN_data_inventory get "inventory")
private _isSlot = _invData get "isSlot";	//0 = Inventory | 1 == Slot

// Reset the used Slots, they will be rebuild later, when the items being added to it.
[_invID, []] call an_c_fnc_ui_inv_grid_tiles_used_set;

if(_DEBUGON)then{private _msg = ["DEBUG: INV_LOAD: _invID             :", _invID]; diag_log _msg, systemchat str _msg;};
if(_DEBUGON)then{private _msg = ["DEBUG: INV_LOAD: invData            :", _invData]; diag_log _msg, systemchat str _msg;};

private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];
private _ctrlArea = uinamespace getvariable [_areaName, controlNull];
// No rows given (most likely an Inventory that is not active (e.g. no Uniform/Vest/Backpack worn))
if(_gridRows == 0)exitWith
{
	//ToDo: Hide unused Inventories properly
	_ctrlGrid ctrlShow false;
	_ctrlArea ctrlShow false;
	if(_DEBUGON)then{private _msg = ["DEBUG: INV_LOAD: NO ROWS IN INV     :", _gridName]; diag_log _msg, systemchat str _msg;};
};

private _gridW = (ctrlPosition _ctrlGrid)#2;
private _gridH = ((_gridW / 0.75) / _gridCols) * _gridRows;	//adjust to 4/3 Value

private _tileH = _gridH/_gridRows;



// adjust the height of the ctrlGroup (grid)
_ctrlGrid ctrlSetPositionH _gridH;
_ctrlGrid ctrlCommit 0;

// adjust the height of the CtrlGroup-parent of the used grid - unless it exceeds the base value - Info: used in: ui_inv_mPos_check_mouse_z
if(_gridH < (ctrlPosition _ctrlArea)#3)then
{
	_ctrlArea ctrlSetPositionH _gridH;
	_ctrlArea ctrlCommit 0;
};

//also of the Background (DEV IDC)
private _ctrlGridBg = _ctrlGrid controlsGroupCtrl 99999;
_ctrlGridBg ctrlSetPositionH _gridH;
_ctrlGridBg ctrlCommit 0;


private _disp = uiNamespace getVariable ["an_inventory",displayNull];
if(isNull _disp)exitWith{systemchat "ERROR: UI_INV_LOAD: isNull _disp";};
// create the "row"-images, inside the given _ctrlGrid
for "_pY" from 0 to (_gridRows-1)do
{
	// use its Y Coord as IDC
	private _idc = _pY;
	// add it to the "inventory"-area
	private _ctrl = _disp ctrlCreate [format["tile_bg_%1",_gridName],_idc,_ctrlGrid];
	
	// If a Slot: Don't add the "grid" texture, instead use the given background image.
	// Means: No adjustements needed! Create the tile background and exit afterwards.
	if(_isSlot == 1)exitWith{};
	
	_ctrl ctrlSetposition [0,(_tileH*_pY),_gridW,_tileH];
	_ctrl ctrlCommit 0;
};


