/*
	create an Item at clicked position
	
	an_c_fnc_ui_inv_item_create
	[
		CTRL	ctrlGrp to add to	//grid_personal ("an_inv_player_grid")
		FLOAT	pos inside ctrlGrp
		FLOAT	y pos inside ctrlGrp
		[
			STRING	item name (Classname) //DEV: Currently STRING path to icon!!
			ARRAY	Variables (like attachements, status, etc)
			BOOL	can be flipped 90°?
		]
		ARRAY	currently used slots (NOT THE OFFSET of the Item itself!) ( e.g: [[0,1],[0,2],[0,3],...] )
	]
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

params["_ctrl_invGrid","_pos_x","_pos_y","_item_class","_usedSlots"];

//get Item parentData
private _parent_data = _item_class call an_c_fnc_ui_inv_item_data_parent_get;
ENTRY_GET("size",_parent_data) params ["_parent_size_y", "_parent_size_x"];

private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
//create the Icon
private _item_IDC = localNamespace getVariable ["an_Item_IDC_count",107441];
private _ctrl_item = _disp ctrlCreate ["inv_icon",_item_IDC,_ctrl_invGrid];
localNamespace setVariable ["an_Item_IDC_count",(_item_IDC + 1)];

(ctrlPosition _ctrl_invGrid)params["_grid_x","_grid_y","_grid_w","_grid_h"];


private _gridSize = localNamespace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrl_invGrid)], [-1,-1]];
_gridSize params["_gridRows","_gridCols"];
if(_gridRows isEqualTo [-1,-1])exitWith{systemchat str ["ITEM_CREATE: GRID NOT SET!", _gridRows];};

private _tile_W = _grid_w / _gridCols;
private _tile_H = _grid_h / _gridRows;

// systemchat str [!_canFlip, !an_inv_move_placeHorizontal];
private _canFlip = if(_parent_size_y == _parent_size_x)then{0}else{1};
if((_canFlip == 0) && !an_inv_move_placeHorizontal)then{an_inv_move_placeHorizontal = true};
//get width and height of selected icon
private _ctrl_item_w = if(an_inv_move_placeHorizontal)then{_tile_W*_parent_size_x}else{_tile_H*_parent_size_y};
private _ctrl_item_h = if(an_inv_move_placeHorizontal)then{_tile_H*_parent_size_y}else{_tile_W*_parent_size_x};


//if needed -> "rotate" the main ctrlGroup and adjust the values to 4/3 (Arma Base Resolution)
if(an_inv_move_placeHorizontal)then
{
	_ctrl_item ctrlSetposition [_pos_x,_pos_y,_ctrl_item_w,_ctrl_item_h];
}else{
	_ctrl_item ctrlSetposition [_pos_x,_pos_y,(_ctrl_item_w*0.75),(_ctrl_item_h/0.75)];
};
_ctrl_item ctrlCommit 0;

//Adjust the image and background of the Item
{
	private _ctrl = _ctrl_item controlsGroupCtrl _x;
	_ctrl ctrlSetposition [0,0,_ctrl_item_w,_ctrl_item_h];
	_ctrl ctrlCommit 0;
	if(_x == 200)then
	{
		private _item_img = ENTRY_GET("image",_parent_data);
		if(_item_img isEqualTo "")then
		{
			private _cfgBase = [ENTRY_GET("slot",_parent_data)] call an_c_fnc_ui_inv_item_getClass;
			_item_img = getText(configFile >> _cfgBase >> _item_class >> "picture");
		}else{
			// DEV / TODO: Workaround until .dll is fixed!
			// _item_img = format["\%1",(_item_img splitString "\\" joinString "\")];
		};
		_ctrl ctrlSetText _item_img;
	};
	//if flipped/roated by 90° -> do other stuff
	if !(an_inv_move_placeHorizontal)then
	{
		//rotate the img with the current Width and Height
		_ctrl ctrlSetAngle [90, 0.5, 0.5];
		
		//Adjust the Width and Height afterwards to the baseRes of 4/3 (Don't ask, ctrlSetAngle is "special"... ...)
		_ctrl ctrlSetposition [0,0,(_ctrl_item_w*0.75),(_ctrl_item_h/0.75)];
		_ctrl ctrlCommit 0;
	};
}forEach[100,200];


private _item_invID_new = if((ctrlIDC _ctrl_invGrid) isEqualto 1001)then{localNamespace getVariable ["an_inv_external_active",""]}else{getPlayerUID player};

// get Item ID
private _item_id = [] call an_c_fnc_ui_inv_item_active_id_get;
// get item data for given ID
private _item_data = localNamespace getVariable [_item_id,[]];

// Get current inventory and its position in it
private _item_pos_old = ENTRY_GET("invPos", _item_data);
private _item_invID_old = ENTRY_GET("curInv", _item_data);

// Check if the position is the same as before AND if it is in the old Inventory (Short: Check if it was moved, or just added (e.g: inv_load)!)
private _isSamePos = _item_pos_old isEqualTo (_usedSlots#0);
private _isSameInv = _item_invID_old in ["",_item_invID_new];
if!( _isSamePos && _isSameInv)then
{
	// if not -> Send a message to the backend, that you moved an Item.
	diag_log ["itemMove", [_item_id, _item_invID_old, _item_invID_new, ENTRY_GET("isFlipped", _item_data), (_usedSlots#0)]];
	
	// update the item data (DEV / NOTE: rebuilding Array faster? Needs to be tested later)
	private _update_item_vars =
	{
		params["_dataset", "_tag", "_var"];
		{
			if((_x#0) isEqualTo _tag)exitWith
			{
				_dataset set[_forEachIndex,[_tag, _var]];
			};
		}forEach _dataset;
	};
	[_item_data, "curInv", _item_invID_new] call _update_item_vars;
	[_item_data, "invPos", (_usedSlots#0)] call _update_item_vars;

	// Store the changes
	localNamespace setVariable [_item_id, _item_data];
	
	// send command to the backend, to update its data.
	["itemMove", [_item_id, _item_invID_old, _item_invID_new, ENTRY_GET("isFlipped", _item_data), (_usedSlots#0)]] call AN_G_fnc_msg_send;
	
	
	/////////////////////////////////////
	// ToDo: Move to seperate function!
	// Update player Inventory
	// NOTE: The remote Inventory will never be saved localy! So only the player Inventory needs to be updated!:
	// get Current Inventory data
	private _cData_inventoryData_cur = localNamespace getVariable ["an_cData_invData",[]];
	// {diag_log ["CHECK: PRE : ",_x];}forEach _cData_inventoryData_cur;
	private _itemDataPlayer = ENTRY_GET("itemData", _cData_inventoryData_cur);
	// {diag_log ["CHECK: PRE : ",_x];}forEach _itemDataPlayer;
	
	//check if it needs to be deleted:
	if(_item_invID_new isEqualTo (getPlayerUID player))then
	{
		// update OR add item
		if(_item_invID_old isEqualTo (getPlayerUID player))then
		{
			// diag_log ["!!!!! CREATE: UPDATE ITEM !!!!!"];
			{
				if((_x#0) isEqualTo _item_id)exitWith
				{
					_itemDataPlayer set [_forEachIndex, [_item_id, _item_data]];
				};
			}forEach _itemDataPlayer;
		}
		else
		{
			// diag_log ["!!!!! CREATE: ADD ITEM !!!!!"];
			_itemDataPlayer pushback [_item_id, _item_data];
		};
	}
	else
	{
		// diag_log ["!!!!! CREATE: DELETE ITEM !!!!!"];
		{
			if((_x#0) isEqualTo _item_id)exitWith
			{
				_itemDataPlayer deleteAt _forEachIndex;
			};
		}forEach _itemDataPlayer;
	};

	// Update the local Player Inventory Data
	localNamespace setVariable ["an_cData_invData",
		[
			["crateID", ENTRY_GET("crateID", _cData_inventoryData_cur)],
			["inv_rows", ENTRY_GET("inv_rows", _cData_inventoryData_cur)],
			["itemData", _itemDataPlayer ]
		]
	];
	/////////////////////////////////////
};

diag_log ["CREATE _item_data: ", _item_data];
// Update the ctrl with the updated ItemData
[_ctrl_item, [[_pos_x,_pos_y,_ctrl_item_w,_ctrl_item_h],_usedSlots,_item_class,_item_id]] call an_c_fnc_ui_inv_item_data_set;