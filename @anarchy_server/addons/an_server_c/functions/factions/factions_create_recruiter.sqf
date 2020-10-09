/*
    File: fn_factions_create_recruiter.sqf
    Author: Spoffy
    Date: 2020-10-08
    Last Update: 2020-10-08
    Public: Yes
    
    Description:
		Creates a recruiter at the given position and direction
    
    Parameter(s):
		_side - Side the cruiter is on.
		_pos - Position to spawn the recruiter at, AGL [ARRAY]
		_dir - Direction to spawn the recruiter facing [NUMBER]
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
		[] call an_s_fnc_factions_create_recruiter
*/

params ["_side", "_pos", ["_dir", 0]];

//This handles the fact 'independent' is turned into "GUER"
private _sideName = if (_side == independent) then {"independent"} else {str _side};
private _recruiterClass = getText (configFile >> "anarchy" >> "factions" >> _sideName >> "recruiter_npc_class");
if (_recruiterClass == "") then {_recruiterClass = "C_Soldier_VR_F"};

private _recruiter = createAgent [_recruiterClass, _pos, [], 0, "NONE"];
_recruiter setDir _dir;
_recruiter setPos _pos;
_recruiter removeWeapon (primaryWeapon _recruiter);
_recruiter removeWeapon (secondaryWeapon _recruiter);
_recruiter removeWeapon (handgunWeapon _recruiter);
removeBackpack _recruiter;
_recruiter allowDamage false;

//Set them to have a "recruiter" interaction overlay
_recruiter setVariable ["#para_InteractionOverlay_ConfigClass", "Recruiter", true];
_recruiter setVariable ["an_s_recruiter_side", _side];
//Add a "Join Faction" action.
[_recruiter, "recruiter_join_faction"] remoteExec ["para_c_fnc_wheel_menu_add_obj_action_from_config", 0, _recruiter];

