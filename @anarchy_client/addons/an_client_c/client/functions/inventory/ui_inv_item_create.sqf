/*
	create an Item at clicked position
	
	an_c_fnc_ui_inv_item_create
	[
		CTRL	ctrlGrp to add to	//an_inv_(uni|vst|pch|bkp|external)_grid
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
private _DEBUGON = false;
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

params["_ctrlInvGrid","_posX","_posY","_itemClass","_usedSlots","_slotID"];

private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
//create the Icon
private _itemIDC = localNamespace getVariable ["an_Item_IDC_count",107441];
private _ctrlItem = _disp ctrlCreate ["inv_icon",_itemIDC,_ctrlInvGrid];
localNamespace setVariable ["an_Item_IDC_count",(_itemIDC + 1)];

// Get the proper Size, related to Grid Size
([_parentData, _ctrlInvGrid] call an_c_fnc_ui_inv_item_size_calc) params ["_ctrlItemW","_ctrlItemH"];

//if needed -> "rotate" the main ctrlGroup and adjust the values to 4/3 (Arma Base Resolution)
if(an_inv_move_placeHorizontal)then
{
	_ctrlItem ctrlSetposition [_posX,_posY,_ctrlItemW,_ctrlItemH];
}else{
	_ctrlItem ctrlSetposition [_posX,_posY,(_ctrlItemW*0.75),(_ctrlItemH/0.75)];
};
_ctrlItem ctrlCommit 0;

//Adjust the image and background of the Item
{
	private _ctrl = _ctrlItem controlsGroupCtrl _x;
	_ctrl ctrlSetposition [0,0,_ctrlItemW,_ctrlItemH];
	_ctrl ctrlCommit 0;
	if(_x == 200)then
	{
		private _itemImg = ENTRY_GET("image",_parentData);
		// If no image is set -> Its most likely an Item, defined in the config. So try to get the image from there.
		if(_itemImg isEqualTo "")then
		{
			private _cfgBase = [ENTRY_GET("slot",_parentData)] call an_c_fnc_ui_inv_item_getClass;
			_itemImg = getText(configFile >> _cfgBase >> _itemClass >> "picture");
		};
		
		_ctrl ctrlSetText _itemImg;
	};
	//if flipped/roated by 90° -> do other stuff
	if !(an_inv_move_placeHorizontal)then
	{
		//rotate the img with the current Width and Height
		_ctrl ctrlSetAngle [90, 0.5, 0.5];
		
		//Adjust the Width and Height afterwards to the baseRes of 4/3 (Don't ask, ctrlSetAngle is "special"... ...)
		_ctrl ctrlSetposition [0,0,(_ctrlItemW*0.75),(_ctrlItemH/0.75)];
		_ctrl ctrlCommit 0;
	};
}forEach[100,200];

////////////////////////////////
//ToDo: Rework needed, when multiple Inventories were added!
private _invExternalID = localNamespace getVariable ["an_inv_external_active",""];	// Is set during the opening init the Inventory
private _invGridExternal = uinamespace getvariable ['an_inv_external_grid', controlNull];
private _gridActive = (ctrlIDC _ctrlInvGrid);
private _itemInvIDNew = if(_gridActive isEqualto (ctrlIDC _invGridExternal))then{_invExternalID}else{getPlayerUID player};
// systemchat str ["_itemInvIDNew", ctrlIDC _invGridExternal, (ctrlIDC _ctrlInvGrid), _itemInvIDNew, ((ctrlIDC _ctrlInvGrid) isEqualto (ctrlIDC _invGridExternal))];
////////////////////////////////

// get Item ID
private _itemID = [] call an_c_fnc_ui_inv_item_active_id_get;
// get item data for given ID
private _itemData = localNamespace getVariable [_itemID,[]];

// Get the current Inventory...
private _itemPosCur = ENTRY_GET("invPos", _itemData);
private _isSamePos = _itemPosCur isEqualTo (_usedSlots#0);
// ... its subInventory ...
private _itemInvSubCur = ENTRY_GET("invSub", _itemData);
// ... its Position ...
_itemInvIDCur = ENTRY_GET("curInv", _itemData);
private _isSameInv = _itemInvIDCur in ["",_itemInvIDNew];
// ... and Slot ...
private _itemInSlotCur = ENTRY_GET("inSlot", _itemData);
private _isSameSlot = _itemInSlotCur == _slotID;

// Get the active Grid IDC - If it's a Slot -> "0"
private _invGearID = if(_slotID > 0)then{"0"}else{str(_gridActive-1000)};	// 12 = Uniform

// Check if the position is the same as before AND if it is in the old Inventory (Short: Check if it was moved, or just added (e.g: inv_load)!)
if !(_isSamePos && _isSameInv && _isSameSlot)then
{
	// if not -> Send a message to the backend, that you moved an Item.
	
	// update the item data (DEV / NOTE: rebuilding the Array faster? Needs to be tested later)
	private _updateItemVars =
	{
		params["_dataset", "_tag", "_var"];
		{
			if((_x#0) isEqualTo _tag)exitWith
			{
				_dataset set[_forEachIndex,[_tag, _var]];
			};
		}forEach _dataset;
	};
	[_itemData, "curInv", _itemInvIDNew] call _updateItemVars;
	[_itemData, "invPos", (_usedSlots#0)] call _updateItemVars;
	// TODO: Update "inSlot", if put in or taken out of a Slot
	[_itemData, "inSlot", _slotID] call _updateItemVars;
	
	// Store the changes
	localNamespace setVariable [_itemID, _itemData];
	
	// If needed: Update the slotted Items:
	// systemchat str ["_isSameSlot", _isSameSlot];
	if(!_isSameSlot)then
	{
		// If moving FROM Slot TO Inventory -> Remove from "slotted list"
		if(_itemInSlotCur != 0)then
		{
			private _removedFromSlot = [_itemInSlotCur] call an_c_fnc_ui_inv_item_slotted_remove;
			// systemchat str ["_itemInSlotCur != 0", _removedFromSlot, _itemInSlotCur != 0];
			if(!_removedFromSlot)then
			{
				systemchat format["ERROR: ITEM_CREATE: ITEM NOT REMOVED FROM SLOT! : Slot: %1 - ItemData: %2", _slotID, _itemData];
				diag_log format["ERROR: ITEM_CREATE: ITEM NOT REMOVED FROM SLOT! : Slot: %1 - ItemData: %2", _slotID, _itemData];
			};
		};
		// If moving FROM Inventory TO Slot -> Add to slotted List!
		if(_slotID != 0)then
		{
			private _addToSlot = [_slotID, _itemData] call an_c_fnc_ui_inv_item_slotted_add;
			// systemchat str ["_slotID != 0", _addToSlot, _slotID != 0];
			if(!_addToSlot)then
			{
				systemchat format["ERROR: ITEM_CREATE: ITEM NOT ADDED TO SLOT! : Slot: %1 - ItemData: %2", _slotID, _itemData];
				diag_log format["ERROR: ITEM_CREATE: ITEM NOT ADDED TO SLOT! : Slot: %1 - ItemData: %2", _slotID, _itemData];
			};
		};
	};
	
	// send command to the backend, to update its data.
	if(_DEBUGON)then{diag_log ["DEBUG: item_create: MSG SEND Data:", ["inv_itemMove", [_itemID, _itemInvIDCur, _itemInvIDNew, ENTRY_GET("isFlipped", _itemData), (_usedSlots#0), _slotID, _invGearID]]];};
	
	["inv_itemMove", [_itemID, _itemInvIDCur, _itemInvIDNew, ENTRY_GET("isFlipped", _itemData), (_usedSlots#0), _slotID, _invGearID]] call AN_G_fnc_msg_send;
	
	// Update the local Inventory
	[_itemInvIDCur,_itemInvIDNew,_itemData,_itemID, _invGearID] call an_c_fnc_ui_inv_data_update;
};

if(_DEBUGON)then{diag_log ["CREATE _itemData: ", _itemData];};
// Update the ctrl with the updated ItemData
[_ctrlItem, [[_posX,_posY,_ctrlItemW,_ctrlItemH],_usedSlots,_itemClass,_itemID]] call an_c_fnc_ui_inv_item_data_set;