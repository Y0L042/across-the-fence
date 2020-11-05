/*
	File: fn_action_supplies.sqf
	Author: Aaron Clark <vbawol>, Spoffy
	Date: 2020-05-23
	Last Update: 2020-07-04
	Public: No

	Description:
		Adds action to request supplies

	Parameter(s):
		_object - Object [Object]

	Returns: nothing

	Example(s):
		call vn_mf_fnc_action_supplies;
*/

params ["_object"];

private _gamemode_config = (missionConfigFile >> "gamemode");

private _supplydrops = configProperties [_gamemode_config >> "supplydrops"];
// add supply officer actions
{
    private _request = configName _x;


    getArray(_gamemode_config >> "supplydrops" >> _request) params ["_request_name", "" ,"_image"];

	[
		_object,
		true,
		_image,
		"",
		[_request, _object],
		format [localize "STR_vn_mf_requestdrop", localize _request_name],
		"vn_an_fnc_client_request_supplies"
	] call para_c_fnc_wheel_menu_add_obj_action;
} forEach _supplydrops;