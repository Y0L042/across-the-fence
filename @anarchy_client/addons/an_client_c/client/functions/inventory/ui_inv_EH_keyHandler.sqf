/*
    File: ui_inv_EH_keyHandler.sqf
    Author: Dscha
    Date: 2020-11-11
    Last Update: 2020-11-11
    Public: No
    
    Description:
        Key DisplayEventhandler for Inventory Opening
    
    Parameter(s):
		0: Control/Display
		1: Pressed Key
		2: State Shift
		3: State Ctrl
		4: State Alt
    
    Returns:
		None
    
    Example(s):
		(findDisplay 46) displayAddEventHandler ["keyUp",{call an_c_fnc_ui_inv_EH_keyHandler;}];
*/
private _DEBUGON = false;
disableSerialization;
params ["_ctrl", "_btn", "_btn_shift", "_btn_ctrl", "_btn_alt"];
private _ButtonDisabled = false;
private _BD = {_ButtonDisabled = true;};
// "G"
if(_btn == 34)then
{
	// Disable the normal input for this button, by returning "true", at the end of the file.
	call _BD;
	
	// Set the max distance to objects.
	private _dist_max = 2;
	private _cObj = cursorObject;
	player setVariable["an_inv_dropActive",true];
	//Check if something is targeted, if not -> search for more
	if !(_cObj getVariable ['an_c_looting_is_crate', false])then
	{
		// Lets assume, that the player just wants to open his Inventory. So we assign him here.
		private _crate = player;
		// Get the nearest lootcrates
		private _nearestLootCrate = an_c_looting_spawned_crates inAreaArray [getPos player, 2, 2];
		// If there are multiples close by -> select the closest one.
		private _nearestLootCrate_cnt = count(_nearestLootCrate);
		if(_nearestLootCrate_cnt > 0)then
		{
			// Only one? Select it then.
			if(_nearestLootCrate_cnt == 1)exitWith{_crate = _nearestLootCrate#0};
			// More than one? Check which one is the closest one.
			private _dist = 2;
			{
				_distCheck = _x distance player;
				if(_distCheck < _dist)then{_dist = _distCheck; _crate = _x; };
			}forEach _nearestLootCrate;
			player setVariable["an_inv_dropActive",false];
		}
		else
		{
			// No Lootcrates found? Check if there are some droppedCrates
			private _droppedBox = nearestObject [player, "Land_Ammobox_rounds_F"];
			// private _droppedBox = (getPos player) nearestObject "Land_Ammobox_rounds_F";
			if!(isNull _droppedBox)then
			{
				if(player distance _droppedBox < _dist_max)exitWith
				{
					// A crate was found, so lets search for it
					_crate = _droppedBox;
					player setVariable["an_inv_dropActive",false];
				};		
			};
		};
		
		// If there were loot- or droppedCrates close by
		if !(_crate isEqualTo player)then
		{
			// check if something ostructs the line of sight (e.g: a Wall)
			private _LISW_check = lineIntersectsWith[eyePos player, getPosASL _crate]#0;
			// Reset back to the player, if something is in the way.
			if !(_LISW_check isEqualTo _crate)exitWith
			{
				_crate = player;
				player setVariable["an_inv_dropActive",false];
			};
		};
		if(_DEBUGON)then{systemchat str["EH KEYHANDLER: _droppedBox", getPosATL _crate];};
		if(_DEBUGON)then{systemchat str["EH KEYHANDLER: dropActive ", (player getVariable "an_inv_dropActive")];};
		if(_DEBUGON)then{diag_log ["EH KEYHANDLER: _droppedBox", getPosATL _crate, _crate];};
		if(_DEBUGON)then{diag_log ["EH KEYHANDLER: dropActive ", (player getVariable "an_inv_dropActive")];};
		// finaly request the Inventory
		[_crate] call AN_C_fnc_loot_inv_request;
	}
	else
	{
		// Lootcrate was found, so lets request the Inventory
		player setVariable["an_inv_dropActive",false];
		if(player distance _cObj < _dist_max)then{ [_cObj] call AN_C_fnc_loot_inv_request; };
	};
};

//EOF:
_ButtonDisabled