
private _inv = ["",""];
{
	private _isIn = [(_x#0)] call an_c_fnc_ui_inv_mPos_check_inInv;
	if(_isIn)exitWith{_inv = _x;};
}forEach AN_INVENTORY_LIST;

_inv
