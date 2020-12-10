
private _DEBUGON = false;

params["_itemList"];

diag_log ["DEBUG: ITEM DATA INIT: START: Items:", count _itemList];
AN_data_items = createHashMap;
private _itemData = createHashMap;
_start = diag_tickTime;
{
	_x params ["_item_name","_itemData_raw"];
	if(_DEBUGON)then{diag_log ["DEBUG: ITEM DATA INIT: Item Data  _item_name:", _item_name, " - ", _itemData_raw];};
	_itemData = createHashMap;
	_itemData insert _itemData_raw;
	if(_DEBUGON)then{diag_log ["DEBUG: ITEM DATA INIT: Item Data  _itemData:", _itemData];};
	AN_data_items set [_item_name, _itemData];
}forEach _itemList;
_finish = diag_tickTime - _start;

diag_log ["DEBUG: ITEM DATA INIT: FINISHED: Time:", _finish];


