/*
	Called after closing the Inventory from the Client. Triggers the creation of the droppedCrate for the Client.
	
	atm with globaly created objects (WIP), due to issues with simpleObjects and its update over the Netcode (e.g: visible, but can't be targeted)
*/

private _pos = _player getVariable["an_inv_lastPos", [0,0,0]];	// set in "loot_request_crate_inventory", while checking if droppedCrate
// reset the stored Var.
_player setVariable["an_inv_lastPos", [0,0,0]];

if(_pos isEqualTo [0,0,0])exitWith
{
	private _message = format ["Anarchy Error: items_dropped: Pos was not set : %1",_pos];
	diag_log _message;
	[_message] remoteExecCall ["systemChat", _player];
};

private _crate = "Land_Ammobox_rounds_F" createVehicle [0,0,0];
_crate allowDamage false;
_crate enableSimulationGlobal false;
_crate setPosATL _pos;

// _message = format["LOOT_ITEMS_DROPPED - _pos: %1", _pos];
// [_message] remoteExecCall ["systemChat", _player];
// [_message] remoteExecCall ["diag_log", _player];