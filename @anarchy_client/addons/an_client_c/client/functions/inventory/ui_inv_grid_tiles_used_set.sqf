private _DEBUGON = false;
params["_gridIDC", "_used_list"];
// set used slots for the given grid IDC
private _invData = AN_data_inventory get "inventory" get _gridIDC;
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: _gridIDC   : ",_gridIDC];};
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: _used_list : ",_used_list];};
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: invData    : ",_invData];};

_invSlotsUsed = _invData set ["slotsUsed", _used_list];