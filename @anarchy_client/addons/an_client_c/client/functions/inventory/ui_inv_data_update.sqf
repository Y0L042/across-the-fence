
// Update player Inventory
// Note: Only the player Inventory will be saved permanentely! External Inv will be reset, when closing the Inventory!
params["_itemInvIDNew","_itemData","_itemID"];

// get Current Item data
private _itemDataPlayer = AN_data_inventory get "itemData";

//check if it needs to be deleted:
if(_itemInvIDNew isEqualTo (getPlayerUID player))then
{
	_itemDataPlayer set [_itemID, _itemData];
}
else
{
	_itemDataPlayer deleteAt _itemID;
};
