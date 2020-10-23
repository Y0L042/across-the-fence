
    /////////////////////////////////////////////////
   // DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV DEV //
  /////////////////////////////////////////////////
 ///// EVERYTHING IN HERE IS PURE DEV STUFF! /////
/////////////////////////////////////////////////

DEV_an_fnc_hintGrid =
{
	params["_grid"];
	
	_formated = "";
	{
		_formated = format["%1\n%2", _formated, _x];
	}foreach _grid;
	
	hintsilent _formated;
};


an_fnc_bandage_use = {systemChat str["FUNCTION CALLED: an_fnc_bandage_use"];};
an_fnc_FAK_use = {systemChat str["FUNCTION CALLED: an_fnc_FAK_use"];};
an_fnc_MediKit_use = {systemChat str["FUNCTION CALLED: an_fnc_MediKit_use"];};