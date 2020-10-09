/*
	class CLASSNAME {
		name = "";
		icon = "";
		description = "";
		variables[] = {}; // String array of code
	};
*/

class Settings {
	distance = 6;
	liveText = 1;
	defaultKey = 7;
};

class FactionRecruiter {
	name = $STR_vn_mf_overlay_recruiter_name;
	icon = "";
	description = $STR_vn_mf_overlay_recruiter_description;
	variables[] = {};
};

class Land_vn_b_prop_mapstand_01 {
	name = "Map on a piece of wood";
	icon = "";
	description = "Health: <t color='#FF0000'>%2%1</t><br/>Distance: %3m";
	variables[] = { "'%'", "round (100 - (damage _object) * 100)", "round (_object distance player)" };
};