/*
	Called after closing the Inventory from the Client. Triggers the creation of the droppedCrate for the Client.
	
	atm with globaly created objects (WIP), due to issues with simpleObjects and its update over the Netcode (e.g: visible, but can't be targeted)
*/


private _pos = [_player] call an_s_fnc_loot_last_pos_get;

// reset the stored Var
[_player, [0,0,0]] call an_s_fnc_loot_last_pos_set;

if(_pos isEqualTo [0,0,0])exitWith
{
	// reset the stored Var
	[_player, [0,0,0]] call an_s_fnc_loot_last_pos_set;
	
	private _message = format ["Anarchy Error: items_dropped: Pos was not set : %1",_pos];
	diag_log _message;
	[_message] remoteExecCall ["systemChat", _player];
};

// private _crate = "Land_Ammobox_rounds_F" createVehicle [0,0,0];
// _crate allowDamage false;
// _crate enableSimulationGlobal false;
private _crate = createSimpleObject ["Land_Ammobox_rounds_F", [0,0,0]];
_crate setPosATL _pos;

// _message = format["LOOT_ITEMS_DROPPED - _pos: %1", _pos];
// [_message] remoteExecCall ["systemChat", _player];
// [_message] remoteExecCall ["diag_log", _player];