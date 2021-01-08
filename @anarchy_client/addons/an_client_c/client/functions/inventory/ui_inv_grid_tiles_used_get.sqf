/*
	"wrapper" to get the used Slots of given inventory
*/

private _DEBUGON = false;

params[["_subInvID","",[""]]];

if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_GET: _subInvID : ",_subInvID];};
if(_subInvID isEqualTo "")exitWith{[]};

// get used slots from the given grid IDC (STRING'd)
(AN_data_inventory get "inventory" get _subInvID get "slotsUsed")