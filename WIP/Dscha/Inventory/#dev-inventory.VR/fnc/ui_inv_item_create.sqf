/*
	create an Item at clicked position
	
	an_fnc_ui_inv_item_create
	[
		CTRL	ctrlGrp to add to	//grid_personal ("an_inv_player_grid")
		FLOAT	pos inside ctrlGrp
		FLOAT	y pos inside ctrlGrp
		[
			STRING	item name (Classname) //DEV: Currently STRING path to icon!!
			ARRAY	Variables (like attachements, status, rarity, etc)
			BOOL	can be flipped 90°?
		]
		ARRAY	currently used slots (NOT THE OFFSET of the Item itself!) ( e.g: [[0,1],[0,2],[0,3],...] )
	]
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
#include "\vn\ui_f_vietnam_c\ui\vn_uiDefines.inc"

params["_ctrl_invGrid","_pos_x","_pos_y","_item_class","_usedSlots"];

//get Item parentData
private _parent_data = _item_class call an_fnc_ui_inv_item_getData;
ENTRY_GET("size",_parent_data) params ["_parent_size_y", "_parent_size_x"];

private _disp = uinamespace getvariable ["an_inventory", DisplayNull];
//create the Icon
private _item_IDC = missionNameSpace getVariable ["an_Item_IDC_count",107441];
private _ctrlGrp_item = _disp ctrlCreate ["inv_icon",_item_IDC,_ctrl_invGrid];
missionNameSpace setVariable ["an_Item_IDC_count",(_item_IDC + 1)];

(ctrlPosition _ctrl_invGrid)params["_grid_x","_grid_y","_grid_w","_grid_h"];


private _inv_rows = missionNameSpace getVariable [format["an_inv_grid_size_%1",(ctrlIDC _ctrl_invGrid)], -1];
if(_inv_rows < 0)exitWith{systemchat str ["ITEM_CREATE: GRID NOT SET!",_inv_rows];};

private _tile_W = _grid_w / an_inv_size_col;
private _tile_H = _grid_h / _inv_rows;

// systemchat str [!_canFlip, !an_inv_move_placeHorizontal];
private _canFlip = if(_parent_size_y == _parent_size_x)then{0}else{1};
if((_canFlip == 0) && !an_inv_move_placeHorizontal)then{an_inv_move_placeHorizontal = true};
//get width and height of selected icon
private _ctrlGrp_item_w = if(an_inv_move_placeHorizontal)then{_tile_W*_parent_size_x}else{_tile_H*_parent_size_y};
private _ctrlGrp_item_h = if(an_inv_move_placeHorizontal)then{_tile_H*_parent_size_y}else{_tile_W*_parent_size_x};


//if needed -> "rotate" the main ctrlGroup and adjust the values to 4/3 (Arma Base Resolution)
if(an_inv_move_placeHorizontal)then
{
	_ctrlGrp_item ctrlSetposition [_pos_x,_pos_y,_ctrlGrp_item_w,_ctrlGrp_item_h];
}else{
	_ctrlGrp_item ctrlSetposition [_pos_x,_pos_y,(_ctrlGrp_item_w*0.75),(_ctrlGrp_item_h/0.75)];
};
_ctrlGrp_item ctrlCommit 0;

//Adjust the image and background of the Item
{
	private _ctrl = _ctrlGrp_item controlsGroupCtrl _x;
	_ctrl ctrlSetposition [0,0,_ctrlGrp_item_w,_ctrlGrp_item_h];
	_ctrl ctrlCommit 0;
	if(_x == 200)then
	{
		private _item_img = ENTRY_GET("image",_parent_data);
		if(_item_img isEqualTo "")then
		{
			private _cfgBase = [ENTRY_GET("slot",_parent_data)] call an_fnc_ui_inv_item_getClass;
			_item_img = getText(configFile >> _cfgBase >> _item_class >> "picture");
		};
		_ctrl ctrlSetText _item_img;
	};
	//if flipped/roated by 90° -> do other stuff
	if !(an_inv_move_placeHorizontal)then
	{
		//rotate the img with the current Width and Height
		_ctrl ctrlSetAngle [90, 0.5, 0.5];
		
		//Adjust the Width and Height afterwards to the baseRes of 4/3 (Don't ask, ctrlSetAngle is "special"... ...)
		_ctrl ctrlSetposition [0,0,(_ctrlGrp_item_w*0.75),(_ctrlGrp_item_h/0.75)];
		_ctrl ctrlCommit 0;
	};
}forEach[100,200];

// systemchat str ["ctrlCreate: _item_data: ", _item_data];
[_ctrlGrp_item, [[_pos_x,_pos_y,_ctrlGrp_item_w,_ctrlGrp_item_h],_usedSlots,_item_class]] call an_fnc_ui_inv_item_data_set;