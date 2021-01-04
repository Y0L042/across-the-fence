
private _DEBUGON = false;
// #include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
// Update player Inventory
// NOTE: The remote Inventory will never be saved localy! So only the player Inventory needs to be updated!:
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

// Update ItemData
AN_data_inventory set ["itemData",_itemDataPlayer];