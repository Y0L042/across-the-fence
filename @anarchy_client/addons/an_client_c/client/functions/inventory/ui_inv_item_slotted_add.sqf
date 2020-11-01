
params["_slot","_itemData"];
private _slottedItems = localNamespace getVariable ["an_cData_invData_slotted",[]];
private _slotCheck =  _slottedItems findIf {_x#0 isEqualTo _slot};
private _added = false;
if(_slotCheck < 0)then
{
	_slottedItems pushback [_slot, _itemData];
	localNamespace setVariable ["an_cData_invData_slotted",_slottedItems];
	_added = true;
};
_added