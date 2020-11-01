
params["_slot"];
private _removed = false;
_slottedItems = localNamespace getVariable ["an_cData_invData_slotted",[]];
_itemIndex = _slottedItems findIf {_x#0 isEqualTo _slot};
if(_itemIndex >= 0)then
{
	_slottedItems deleteAt _itemIndex;
	localNamespace setVariable ["an_cData_invData_slotted",_slottedItems];
	_removed = true;
};
_removed