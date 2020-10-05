

params["_ctrl_grid","_grid_tiles_used","_item_tiles_used"];
{
	_grid_tiles_used pushbackUnique _x;
}forEach _item_tiles_used;

private _varName_activeCtrl = format["an_inv_tileUsage_%1",(ctrlIDC _ctrl_grid)];
missionNameSpace setVariable [_varName_activeCtrl,_grid_tiles_used];