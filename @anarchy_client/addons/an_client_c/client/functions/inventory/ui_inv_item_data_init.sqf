/*
	
*/
private _DEBUGON = false;

params["_itemList"];

diag_log ["DEBUG: ITEM DATA INIT: START: Items:", count _itemList];
if(isNil "AN_data_itemData_base")then{
	AN_data_itemData_base = createHashMap;
};

private _itemData = Nil;
private _baseData_raw = Nil;
_start = diag_tickTime;
{
	_x params ["_item_name","_itemData_raw"];
	if(_DEBUGON)then{diag_log ["DEBUG: ITEM DATA INIT: Item Data  _item_name   :", _item_name];};
	if(_DEBUGON)then{diag_log ["DEBUG: ITEM DATA INIT: Item Data  _itemData_raw:", _itemData_raw];};
	_itemData = createHashMap;
	_itemData insert _itemData_raw;
	{
		_data_raw = _itemData getOrDefault [_x,[]];
		if !(_data_raw isEqualTo [])then
		{
			private _data = createHashMap;
			_data insert _data_raw;
			_itemData set [_x, _data];
		};
	}forEach ["baseData","parentData","itemData"];
	if(_DEBUGON)then{diag_log ["DEBUG: ITEM DATA INIT: Item Data  _itemData:", _itemData];};
	AN_data_itemData_base set [_item_name, _itemData];
}forEach _itemList;
_finish = diag_tickTime - _start;

diag_log ["DEBUG: ITEM DATA INIT: FINISHED: Time:", _finish];


