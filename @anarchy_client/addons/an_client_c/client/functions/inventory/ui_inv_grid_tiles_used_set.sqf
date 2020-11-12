private _DEBUGON = false;
params["_grid_idc", "_used_list"];
// set used slots for the given grid IDC
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: _grid_idc : ",_grid_idc];};
if(_DEBUGON)then{diag_log ["DEBUG: GRID_TILES_USED_SET: _used_list: ",_used_list];};
localNamespace setVariable [format["an_inv_tileUsage_%1",_ctrl_grid_idc],_used_list];