/*
    File: fn_factions_create_recruiters_at_markers.sqf
    Author: Spoffy
    Date: 2020-10-08
    Last Update: 2020-10-08
    Public: No
    
    Description:
		Creates faction recruiters at all faction recruiter markers.
    
    Parameter(s):
		None
    
    Returns:
		None
    
    Example(s):
		[] call an_s_fnc_factions_create_recruiters_at_markers
*/

private _recruiterMarkers = allMapMarkers select {_x find "recruiter" == 0};

private _sideNames = ["west", "east", "independent"];
private _sides = [west, east, independent];

x = [];

//Figure out the side we need based on the marker name.
private _recruiterMarkersWithSides = _recruiterMarkers apply {
	private _prefixLength = 10;
	private _sideName = _x select [_prefixLength, (_x select [_prefixLength,count _x] find "_")];
	x pushBack _sideName;	
	[_x, _sides select (_sideNames find _sideName)]
};


//Create recruiters at marker positions.
{
	_x params ["_marker", "_side"];
	[_side, getMarkerPos _marker, markerDir _marker] call an_s_fnc_factions_create_recruiter;
} forEach _recruiterMarkersWithSides;