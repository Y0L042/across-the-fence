/*
	File: factions_data_server.sqf
	Author: Dscha
	Date: 2020-10-13
	Last Update: 2020-10-13
	Public: No
	
	Description:
		Set the data for each of the Factions
	
	Parameter(s):
		_faction_data			- MULTI ARRAY
		[
			"SIDE",				- STRING - Side (Arma 3 format)
			[					- MULTI ARRAY
				[
					"STAT",		- STRING - Name of the entry (atm used: "INT")
					VALUE		- INT	 - erm, the value? Represented by an Integer
				]
			]
		]
	
	Returns:
		Nothing
	
	Example(s):
		[
			[
				"WEST",
				[
					["INT",0]
				]
			],
			["EAST",[["INT",0]]],
			["GUER",[["INT",0]]],
			["CIV",[["INT",0]]]
		] call vn_fnc_myFunction
*/

params["_faction_data"];

// Example code below!
{
	_x params["_side","_data"];
	{
		_x params["_data_name","_data_value"];
		// for readability, doing that in an extra variable:
		//				  "faction_CIV_INT"
		//				  "faction_WEST_INT"
		//				  "faction_EAST_INT"
		//				  "faction_GUER_INT"
		_varName = format["faction_%1_%2",_side,_data_name];
		diag_log ["DEBUG: SETTING UP FACTION STATS : _varName:", _varName];
		diag_log ["DEBUG: SETTING UP FACTION STATS : _value  :", _data_value];
		missionNameSpace setVariable [_varName, _data_value];
	}forEach _data;
}forEach _faction_data;