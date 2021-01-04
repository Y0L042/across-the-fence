private _DEBUGON = false;
params["_grid_idc"];
// get used slots from the given grid IDC
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_GET: _grid_idc : ",_grid_idc];};

(AN_data_inventory get "inventory" get str(_grid_idc) get "slotsUsed")