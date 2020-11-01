
params["_grid_idc", "_used_list"];
// set used slots for the given grid IDC
diag_log ["grid_tiles_used_set: _used_list: ", _grid_idc, _used_list];
localNamespace setVariable [format["an_inv_tileUsage_%1",_ctrl_grid_idc],_used_list];