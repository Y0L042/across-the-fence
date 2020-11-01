
params["_grid_idc"];
// get used slots from the given grid IDC
diag_log ["DEBUG: GRID_TILES_USED_GET: _grid_idc : ",_grid_idc];
localNamespace getVariable [format["an_inv_tileUsage_%1",_grid_idc],[]];