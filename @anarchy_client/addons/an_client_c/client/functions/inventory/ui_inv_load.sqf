

private _DEBUGON = false;


params["_invIDC","_invData"];
// _invData = [["invGrid","an_slot_uni_grid"],["invArea","an_slot_uni_area"],["inv_rows",6],["invID",12],["inv_cols",4]]

if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_LOAD: invIDC        : %1", _invIDC];};
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_LOAD: invData       : %1", _invData];};

// if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_LOAD: ctrlGrid      : %1", _ctrlGrid];};

private _gridName = _invData get "invGrid";
private _areaName = _invData get "invArea";
private _gridRows = _invData get "inv_rows";
private _gridCols = _invData get "inv_cols";
private _slotID = _invData get "invID";
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_LOAD: _slotID      : %1", _slotID];};

private _ctrlGrid = uinamespace getvariable [_gridName, controlNull];
private _ctrlArea = uinamespace getvariable [_areaName, controlNull];

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
	
	// IDCs below 1000 AND not 0 == Slot - So don't add the "grid" texture and make it max size of the GridArea
	if(_slotID < 1000 && _slotID != 0)exitWith
	{
		_gridRows = 1;
		_ctrl ctrlSetposition [0,(_tileH*_pY),_gridW,_gridH];
	};
	_ctrl ctrlSetposition [0,(_tileH*_pY),_gridW,_tileH];
	
	_ctrl ctrlCommit 0;
};


















if(true)exitWith{};

















#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"


if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Inventory: %1", _gridName];};

// create the grid
if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: _gridData: %1", _gridData];};
private _gridRows = _gridData get "inv_rows";
private _gridCols = _gridData get "inv_cols";
private _slotID = _gridData getOrDefault ["slotID",0];
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


// set the Var for the EXTERNAL grid and show the "grid images"
// [_ctrlGrid, _gridName] call an_c_fnc_ui_inv_grid_create;

if(_DEBUGON)then{diag_log format["DEBUG: UI_INV_INIT: setting up: Inventory: %1 - DONE", _gridName];};



if(true)exitWith{};
// !!!! ToDo: Move to seperate function !!!!

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// add the Items:
private _DEBUGON = true;

if(_DEBUGON)then{diag_log format["- DEBUG: Loading Items: %1", _itemData];};

if(true)exitWith{};

{
	_x params ["_x_itemId","_x_itemData"];
	if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item Data : %1", _x_itemData];};
	
	private _itemInvSub = ENTRY_GET("invSub",_x_itemData);
	if(_DEBUGON)then{diag_log format["- DEBUG: UI_INV_INIT: setting up: Item InventorySub: %1", _itemInvSub];};
	
	if(_itemInvSub isEqualTo _subGridID)then
	{
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
	};
}forEach _itemData;