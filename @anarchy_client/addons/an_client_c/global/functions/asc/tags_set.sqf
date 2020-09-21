#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

params["_dict"];
{
	_x params["_tag","_fncData"];
	
	_fncName = ENTRY_GET("fnc",_fncData);
	_doSpawn = ENTRY_GET("spawn",_fncData);

	// cheap Check if the tag was already assigned.
	private _test = missionNameSpace getVariable _tag;
	if(isNil "_test")then
	{
		//ToDo: add "isFinal"-SecurityCheck after next Arma Patch (2.00).
		private _fnc = format["_this %1 %2", (["call","spawn"] select _doSpawn),_fncName];
		diag_log ["DEBUG: TAGS_SET: _fnc: ", _fnc];
		missionNameSpace setVariable[_tag, (compileFinal _fnc)];
	};
}forEach _dict;