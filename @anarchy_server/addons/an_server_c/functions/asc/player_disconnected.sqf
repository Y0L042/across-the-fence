

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

_uid call an_s_fnc_asc_player_data_delete;

"asc_extension" callExtension ["call_function", ["user_rem",[_uid]]];