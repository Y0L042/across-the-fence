/*
    File: ui_inv_get.sqf
    Author: Dscha
    Date: 2020-10-31
    Last Update: 2020-12-09
    Public: Yes
    
    Description:
        Check all the Inventories and Slots, if the Mouse is inside and return their area + grid Names, as well as if its a slot or not.
    
    Parameter(s):
		None
    
    Returns:
	ARRAY	[
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
	
	_isIn = [(AN_data_inventory get "inventory" get _x get "invArea")] call an_c_fnc_ui_inv_get_check;
	if(_isIn)exitWith
	{
		systemchat str [diag_tickTime, _x, _isIn];
		_inv = AN_data_inventory get "inventory" get _x;
	};
// }forEach (keys (AN_data_inventory get "inventory_list"));
}forEach (keys (AN_data_inventory get "inventory"));

_inv