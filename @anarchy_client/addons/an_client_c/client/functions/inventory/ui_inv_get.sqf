/*
    File: ui_inv_get.sqf
    Author: Dscha
    Date: 2020-10-31
    Last Update: 2020-12-06
    Public: No
    
    Description:
        Check all the Inventories and Slots, if the Mouse is inside and return their area + grid Names, as well as if its a slot or not.
    
    Parameter(s):
		None
    
    Returns:
		[
			VarName - Area	-	STR		-	"an_inv_external_area"
			VarName - Grid	-	STR		-	"an_inv_external_grid"
			is Slot			-	BOOL	-	true/false
		]
    
    Example(s):
		(call an_c_fnc_ui_inv_get) params ["_area","_grid","_isSlot"];
*/

private _isIn = false;
private _inv = ["","",false];

// Check all Inventories
{
	_isIn = [(_x#0)] call an_c_fnc_ui_inv_get_check;
	if(_isIn)exitWith{_inv = [_x#0,_x#1,false];};
}forEach AN_INVENTORY_LIST;

// If nothing was found, check if inside a SLOT
if(!_isIn)then
{
	{
		_isIn = [(_x#0)] call an_c_fnc_ui_inv_get_check;
		if(_isIn)exitWith{_inv = [_x#0,_x#1,true]; };
	}forEach AN_SLOTS_LIST;
};

_inv