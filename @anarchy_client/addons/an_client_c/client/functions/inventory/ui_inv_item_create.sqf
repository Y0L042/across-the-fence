/*
	create an Item at clicked position
	
	an_c_fnc_ui_inv_item_create
	[
		CTRL	ctrlGrp to add to	//an_inv_(uni|vst|pch|bkp|external)_grid
		FLOAT	x pos inside ctrlGrp
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
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

params["_ctrlInvGrid","_posX","_posY","_itemID"];

private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
//create the Icon
private _itemIDC = localNamespace getVariable ["an_Item_IDC_count",107441];
private _ctrlItem = _disp ctrlCreate ["inv_icon",_itemIDC,_ctrlInvGrid];
localNamespace setVariable ["an_Item_IDC_count",(_itemIDC + 1)];


private _itemData = [_itemID] call an_c_fnc_ui_inv_item_data_get;
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _itemData     :", _itemData];};
private _parentData = [_itemData] call an_c_fnc_ui_inv_item_data_parent_get;
if(isNil "_parentData")exitWith{diag_log format["ERROR: UI_INV_ITEM_CREATE: PARENTDATA NOT FOUND : _itemID: %1 - _itemData: %2", _itemID, _itemData];};

// Get the proper Size, related to Grid Size
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _parentData   :", _parentData];};
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _ctrlInvGrid  :", _ctrlInvGrid];};
private _itemSize = _parentData get "baseData" get "size";
([_itemSize, _ctrlInvGrid] call an_c_fnc_ui_inv_item_size_calc) params ["_ctrlItemW","_ctrlItemH"];
if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: ITEM_W/H      :", [_ctrlItemW, _ctrlItemH]];};

//if needed -> "rotate" the main ctrlGroup and adjust the values to 4/3 (Arma Base Resolution)
if(an_inv_move_placeHorizontal)then
{
	_ctrlItem ctrlSetposition [_posX,_posY,_ctrlItemW,_ctrlItemH];
}else{
	_ctrlItem ctrlSetposition [_posX,_posY,(_ctrlItemW*0.75),(_ctrlItemH/0.75)];
};
_ctrlItem ctrlCommit 0;
_ctrlItem setVariable ["itemID", _itemID];

//Adjust the image and background of the Item
{
	private _ctrl = _ctrlItem controlsGroupCtrl _x;
	_ctrl ctrlSetposition [0,0,_ctrlItemW,_ctrlItemH];
	_ctrl ctrlCommit 0;
	if(_x == 200)then
	{
		private _itemImg = _parentData get "baseData" get "image";
		// If no image is set -> Its most likely an Item, defined in the config. So try to get the image from there.
		if(_itemImg isEqualTo "")then
		{
			if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _parentData   :", _parentData];};
			private _baseData = _parentData get "baseData";
			private _cfgBase = _baseData get "class_type";
			private _cfgName = _baseData get "class_name";
			if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _cfgBase      :", _cfgBase];};
			if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _cfgName      :", _cfgName];};
			_itemImg = getText(configFile >> _cfgBase >> _cfgName >> "picture");
		};
		
		if(_DEBUGON)then{diag_log ["DEBUG: UI_INV_ITEM_CREATE: _itemImg      :", _itemImg];};
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
