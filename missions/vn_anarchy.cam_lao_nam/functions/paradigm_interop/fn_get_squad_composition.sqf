/*
    File: fn_get_squad_composition.sqf
    Author: Spoffy
    Date: 2020-07-31
    Last Update: 2020-07-31
    Public: No
    
	Description:
		Retrieves the units that should be in a squad of a given type, side and size.
	
	Parameter(s):
		_type - Type of squad. [STRING]
		_side - Side the squad should be on [SIDE]
		_size - Size of the squad [NUMBER]
	
	Returns:
		Array of unit class names, with _size members [ARRAY]
	
	Example(s):
		//Make the call paradigm, which delegates to the mission.
		["PATROL", west, 5] call para_g_fnc_spawning_get_squad_composition
*/

params ["_type", "_side", "_squadSize"];

//Cache this in memory, so it can be temporarily updated at runtime.
private _key = format ["vn_an_squad_%1_%2", _side, _type];
private _squadTemplate = missionNamespace getVariable _key;

if (isNil "_squadTemplate") then 
{
	private _fnc_resolveUnitReferences = {
		params ["_unitArray"];
		private _classArray = [];
		{
			if (_x isEqualType []) then {
				_classArray pushBack ([_x] call _fnc_resolveUnitReferences);
			} 
			else 
			{
				private _unitConfig = (missionConfigFile >> "gamemode" >> "units" >> str _side >> _x);
				switch true do 
				{
					case (isArray _unitConfig): {_classArray pushBack ([getArray (_unitConfig)] call _fnc_resolveUnitReferences)};
					case (isText _unitConfig): {_classArray pushBack (getText (_unitConfig))};
					default 
					{
						if (_x isKindOf "Man") then 
						{
							_classArray pushBack _x;
						} 
						else 
						{
							diag_log format ["VN Anarchy ERROR: Bad unit in squad composition %1", _x];
							_classArray pushBack "C_Soldier_VR_F";
						};
					};
				};
			};
		} forEach _unitArray;
		_classArray
	};

	_squadTemplate = getArray (missionConfigFile >> "gamemode" >> "squad_compositions" >> str _side >> _type);
	//Resolve any references to a unit type, rather than a unit.
	_squadTemplate = [_squadTemplate] call _fnc_resolveUnitReferences;
	if (_squadTemplate isEqualTo []) then {
		_squadTemplate = ["C_Soldier_VR_F"];
	};
	missionNamespace setVariable [_key, _squadTemplate];
};

private _squad = [];
private _index = 0;
private _templateSize =	count _squadTemplate;
for "_i" from 1 to _squadSize do 
{
	private _class = _squadTemplate select _index;
	while {_class isEqualType []} do {_class = selectRandom _class;};
	_squad pushBack _class;
	_index = (_index + 1) mod _templateSize;
};
_squad