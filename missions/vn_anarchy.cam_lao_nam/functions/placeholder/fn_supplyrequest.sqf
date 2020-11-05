/*
    File: fn_supplyrequest.sqf
    Author: Aaron Clark <vbawol>
    Date: 2020-01-29
    Last Update: 2020-05-29
    Public: No
    
    Description:
        Moves player to another camp or location.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!
    
    Parameter(s):
		_supply - Supply classname [String]
		_officer - Officier [Object]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_supply","_officer"];

// make sure player is witin 20m of a supply officer
if !([_officer] inAreaArray [getPos _player, 20, 20, 0, false, 20] isEqualTo []) then
{
	private _drop_marker = _officer getVariable "vn_an_supply_drop_marker";
	private _spawn_pos = getMarkerPos _drop_marker;
	private _nearby = _spawn_pos nearSupplies 10;
	if (count _nearby <= 5) then {
		private _drops = getArray(missionConfigFile >> "gamemode" >> "supplydrops" >> _supply);
		_drops params [["_drop_name","STR_vn_mf_supplies"],["_drop_arr",[]]];
		if !(_drop_arr isEqualTo []) then
		{
			private _object = createVehicle [selectRandom _drop_arr, _spawn_pos, [], 1, "NONE"];
			[	[_drop_name],
				{
					["TaskSucceeded",["",format[localize "STR_vn_mf_dropincomming", localize (_this select 0)]]] call para_c_fnc_show_notification
				}
			] remoteExecCall ["call",_player];
		};

	} else {
		{["TaskFailed",["",localize "STR_vn_mf_supplydroponstandby"]] call para_c_fnc_show_notification} remoteExecCall ["call",_player];
	};
};
