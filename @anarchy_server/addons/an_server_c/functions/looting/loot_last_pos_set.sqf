/*
	set stored Var, with the last ATL Pos, at given _unit.
	
	[_unit, [0,0,0]] call an_s_fnc_loot_last_pos_set;
*/
params["_unit","_cratePos"];
_unit setVariable ["an_inv_lastPos", _cratePos, false];