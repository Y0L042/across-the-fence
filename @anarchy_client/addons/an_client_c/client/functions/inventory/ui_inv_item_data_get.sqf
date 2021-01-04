
/*
	just a wrapper, to get the itemData (NOT BASE- OR PARENTDATA!)
	Returns the itemData (hashmap) for given ItemID.
*/
params ["_itemID"];

private _ret = AN_data_inventory get "itemData" get _itemID;
// If item is not in the Inventory, check for the external "data storage"
if(isNil "_ret")then
{
	_ret = AN_data_items_ext get _itemID;
};

_ret
