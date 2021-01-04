/*
	Update the passed item.
	ToDo: Check if even needed, since we are working with the hashmaps and ref. data (probably only deletion needed)
*/

params ["_itemData"];

private _invSub = _itemData get "invSub";
private _itemID = _itemData get "id";

if(_invSub == "1000")then
{
	// External
	AN_data_items_ext set [_itemID, _itemData];
	
	// Check if moved FROM PERSONAL TO EXTERNAL Inventory:
	private _wasMoved = (AN_data_inventory get "itemData") get _itemID;
	if(!isNil _wasMoved)then{(AN_data_inventory get "itemData") deleteAt _itemID};
}else{
	(AN_data_inventory get "itemData") set [_itemID, _itemData];
	
	// Check if moved FROM EXTERNAL TO PERSONAL Inventory:
	private _wasMoved = AN_data_items_ext get _itemID;
	if(!isNil _wasMoved)then{AN_data_items_ext deleteAt _itemID};
};