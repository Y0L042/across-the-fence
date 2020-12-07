
private _DEBUGON = false;
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
// Update player Inventory
// NOTE: The remote Inventory will never be saved localy! So only the player Inventory needs to be updated!:
params["_itemInvIDCur","_itemInvIDNew","_itemData","_itemID"];

// get Current Inventory data
private _invDataCur = localNamespace getVariable ["an_cData_invData",[]];
if(_DEBUGON)then{{diag_log ["CHECK: PRE : ",_x];}forEach _invDataCur;};
private _itemDataPlayer = ENTRY_GET("itemData", _invDataCur);
if(_DEBUGON)then{{diag_log ["CHECK: PRE : ",_x];}forEach _itemDataPlayer;};

//check if it needs to be deleted:
if(_itemInvIDNew isEqualTo (getPlayerUID player))then
{
	// update OR add item
	if(_itemInvIDCur isEqualTo (getPlayerUID player))then
	{
		if(_DEBUGON)then{diag_log ["!!!!! CREATE: UPDATE ITEM !!!!!"];};
		{
			if((_x#0) isEqualTo _itemID)exitWith
			{
				_itemDataPlayer set [_forEachIndex, [_itemID, _itemData]];
			};
		}forEach _itemDataPlayer;
	}
	else
	{
		if(_DEBUGON)then{diag_log ["!!!!! CREATE: ADD ITEM !!!!!"];};
		_itemDataPlayer pushback [_itemID, _itemData];
	};
}
else
{
	if(_DEBUGON)then{diag_log ["!!!!! CREATE: DELETE ITEM !!!!!"];};
	{
		if((_x#0) isEqualTo _itemID)exitWith
		{
			_itemDataPlayer deleteAt _forEachIndex;
		};
	}forEach _itemDataPlayer;
};

// Update the local Player Inventory Data
localNamespace setVariable ["an_cData_invData",
	[
		["crateID", ENTRY_GET("crateID", _invDataCur)],
		["inventory", ENTRY_GET("inventory", _invDataCur)],
		["itemData", _itemDataPlayer ]
	]
];
