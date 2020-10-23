/*
	Handle player joins
*/

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

diag_log str ["AN_ASC - PLAYER_CONNECTED: ", _this];

//Exit if Server "connects" - Don't ask... just simply don't ask...
if(_owner == 2)exitWith{};

/*
Pretty ugly way to wait, to determine if the damn player has finished his initialization, but...
it's needed... Client EH's need to be set up, to reliably receive all the data...
*/
private _timeout = diag_tickTime + 20;
private _ownerPawn = nil;
waitUntil
{
	_ownerPawn = {if(owner _x isEqualTo _owner)exitWith{_x};}forEach allPlayers;
	(!isNil "_ownerPawn" || _timeout < diag_tickTime)
};
if(_timeout < diag_tickTime)exitWith{diag_log format["DEBUG: PLAYER_CONNECTED: CONNECTION TIMEOUT FOR PLAYERID: %1", _owner]};

// create 32Byte TempKey, so we know which client connection belongs to which PlayerUID
private _tKey = call AN_S_fnc_key_create;

// register the connecting player in ASC
"asc_extension" callExtension ["call_function", ["user_add",[_tKey, _uid]]];

// Send the Client the command to connect to the backend directly, without calling any function on the Client!
uisleep 0.5;	// Dev - delay it a bit
(call AN_S_ServerData) params["_ip","_port"];
[
  [_ip,_port, _tKey, _uid],
  {
	params["_ip","_port","_tKey","_uid"];
	// add the Callback EH
	addMissionEventHandler ["ExtensionCallback", AN_C_fnc_ext_CE_callback_client];
	// also sending _uid atm - maybe for an additional check later?
	"asc_extension" callExtension ["init_client",[_ip,_port,_tKey, _uid]];
  }
] remoteExecCall ["call", _owner];




/////////////////////////////////////////
// DEV / TEST STUFF

//---------
// Preps for Weapon Degredation
diag_log "DEBUG: Adding EH 'FIRED' to unit...";
AN_S_fnc_EH_fired =
{
	/*
		unit: Object - Object the event handler is assigned to
		weapon: String - Fired weapon
		muzzle: String - Muzzle that was used
		mode: String - Current mode of the fired weapon
		ammo: String - Ammo used
		magazine: String - magazine name which was used
		projectile: Object - Object of the projectile that was shot out
		Introduced with Arma 3 version 1.651.65 gunner: Object - gunner whose weapons are firing.
	*/
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	// diag_log ["DEBUG: EH: FIRED: _this       : ", _this];
	// diag_log ["DEBUG: EH: FIRED: Current Wpn : ", currentWeapon _unit];
	// if(_weapon isEqualTo primaryWeapon _unit)exitWith{["player_fired", [getPlayerUID _unit, "wpn", 0, _ammo, _mode]] call AN_G_fnc_msg_send;};
	// if(_weapon isEqualTo handgunWeapon _unit)exitWith{["player_fired", [getPlayerUID _unit, "wpn", 1, _ammo, _mode]] call AN_G_fnc_msg_send;};
	// if(_weapon isEqualTo secondaryWeapon _unit)exitWith{["player_fired", [getPlayerUID _unit, "wpn", 2, _ammo, _mode]] call AN_G_fnc_msg_send;};
};
_OwnerPawn addEventHandler ["Fired",{_this call AN_S_fnc_EH_fired}];
diag_log "DEBUG: Adding EH 'FIRED' to unit... done";
//---------

/*
// Postponed until player spawning (incl. Equipment assignement) is added
AN_S_fnc_client_updater_fired =
{

}

// Add scheduler job - update the backend every N seconds
["ASC_EH_fired_updater", AN_S_fnc_client_updater_fired, [], 5] call para_g_fnc_scheduler_add_job;
 */