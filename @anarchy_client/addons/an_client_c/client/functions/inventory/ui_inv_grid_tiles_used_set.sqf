private _DEBUGON = false;
params["_invSubID", "_used_list"];
// set used slots for the given grid IDC
private _invData = AN_data_inventory get "inventory" getOrDefault [_invSubID, []];
// Check if Inventory was found.
if(_invData isEqualTo [])exitWith{};

if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: _invSubID   : ",_invSubID];};
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: _used_list : ",_used_list];};
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: invData    : ",_invData];};

_invData set ["slotsUsed", _used_list];