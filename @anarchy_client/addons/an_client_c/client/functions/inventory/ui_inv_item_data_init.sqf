private _DEBUGON = false;
params["_itemList"];
_start = diag_tickTime;
{
	_x params ["_item_name","_item_data"];
	diag_log ["ITEM DATA RECEIVED: Item Data  _item_name:", _item_name, " - ", _item_data];
	[_item_name, _item_data] call an_c_fnc_ui_inv_item_data_parent_set;
	
}forEach _itemList;
_finish = diag_tickTime - _start;
if(_DEBUGON)then{diag_log ["ITEM DATA RECEIVED: Item Data FINISHED:", _finish];};
