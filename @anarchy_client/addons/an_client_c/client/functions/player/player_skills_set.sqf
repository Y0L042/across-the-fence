/*
    File: player_skills_set.sqf
    Author: Dscha
    Date: 2020-11-04
    Last Update: 2020-11-04
    Public: No
    
    Description:
        Sets the player skills

		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset =	[
						"skills",
						[
							 ["Skillname1",123]
							,["Skillname2",321]
						]
					]
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/
#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];

// Reset the local list
localNameSpace setVariable ["an_c_skills_list",[]];

// Set the skills
private _skills_list = [];
private _data = ENTRY_GET("skills", _dataset);
diag_log format["ASC: Skills received		: %1", _data];
{
	_x params["_skillName","_skillData"];
	diag_log format["ASC: Skill	: %1", _x];
	localNameSpace setVariable ["an_c_skills_"+_skillName, _skillData];
	_skills_list pushback _skillName;
}forEach _data;
// Store the skillnames, to be able to get them later.
localNameSpace setVariable ["an_c_skills_list", _skills_list];