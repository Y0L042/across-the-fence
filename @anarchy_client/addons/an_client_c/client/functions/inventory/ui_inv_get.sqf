
private _inv = ["","",false];
private _isInv = true;
{
	private _isIn = [(_x#0)] call an_c_fnc_ui_inv_mPos_check_inInv;
	if(_isIn)exitWith{_inv = _x;};
}forEach AN_INVENTORY_LIST;

// If nothing was found, check if inside a SLOT
if(_inv isEqualTo ["","",false])then
{
	{
		private _isIn = [(_x#0)] call an_c_fnc_ui_inv_mPos_check_inInv;
		if(_isIn)exitWith{_inv = [_x#0,_x#1,true]; };
	}forEach AN_SLOTS_LIST;
};

_inv