/*

	TODO: Split to two functions: REMOVE ITEM && REMOVE FROM GRID

*/

disableSerialization;

params ["_ctrl", ["_btn",1,[0]]];//, "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];
// _xPos,_yPos = pos relative to GridPos
if(_btn != 1)exitWith{};

//get the used slots from that Item
(_ctrl getVariable ["item_data",[]]) params ["_pos_data","_usedSlots_item","_item_class"];
private _ctrl_grid = ctrlParentControlsGroup _ctrl;
private _ctrl_grid_idc = ctrlIDC _ctrl_grid;
// systemchat str ["FNC_TEST: ", _ctrl_grid," - _usedSlots = ",_usedSlots];

//get Grid for used IDC
private _grid = missionNameSpace getVariable [format["an_inv_grid_%1",_ctrl_grid_idc],[]];
//_grid == [y,x,IDC]

//get used slots from grid
private _varName_activeCtrl = format["an_inv_tileUsage_%1",_ctrl_grid_idc];
private _grid_usedSlots = missionNameSpace getVariable [_varName_activeCtrl,[]];


// get the index pos of the used slots and store it temporarely
private _indexList = [];
{
	private _index = _grid_usedSlots find _x;
	// if something went terribly wrong -> exit the Check and reset the indexList (ToDo: send a msg to the backend, to request Inventory resend/reinit)
	if(_index < 0)exitWith
	{
		_indexList = [];
		systemchat str["ERROR: ITEM_REMOVE: INDEX ENTRY NOT FOUND: ", _x];
		diag_log ["ERROR: ITEM_REMOVE: INDEX ENTRY NOT FOUND: ", _x];
	};
	_indexList pushback _index;
}forEach _usedSlots_item;

// then sort the list "backwards", to have the highest entry at index 0...
_indexList sort false;
// diag_log ["Pre :",_grid_usedSlots];

// ...then delete them, starting from highest index to lowest (avoids to keep track of shifted IndexPos, because of the deletion)
{
	_grid_usedSlots deleteAt _x;
}forEach _indexList;
// diag_log ["Post:",_grid_usedSlots];

missionNameSpace setVariable [_varName_activeCtrl,_grid_usedSlots];

//////////// WARNING:
//NOT SPAWNING the ctrlDelete (executing in the same frame(?)) -> !! ARMA CRASH !!
_ctrl spawn {ctrlDelete _this;};
//////////// WARNING:


// systemchat str ["_usedSlots_item: ",_usedSlots_item];
// systemchat str ["_grid_usedSlots: ",_grid_usedSlots];