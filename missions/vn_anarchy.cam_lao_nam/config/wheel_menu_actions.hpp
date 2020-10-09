/*
 * File: wheel_menu_actions.hpp
 * Author: Spoffy
 * Description:
 *    Description goes here
 * Params:
 *    None
 * Returns:
 *    None
 * Example Usage:
 *    Example usage goes here
 */
class wheel_menu_actions 
{
	class base_action 
	{
		//In what situations should the action be visible.
		//ALWAYS is always shown.
		//NO_TARGET is shown when the player isn't looking at an object.
		//Anything else means the action needs to be explicitly shown by the code, such as added to an object.
		visible = "";
		//Action is only visible when condition returns "true"
		condition = "true";
		//Text to display
		text = "";
		//Path to the icon to be shown
		icon = "";
		//Path to the icon to be shown when the entry is highlighted.
		icon_highlighted = "";
		//Arguments to pass to the function, compiled to code.
		arguments = "";
		//Function to call. Looked up in mission namespace.
		function = "";
		//Whether to spawn the function, or call it. 0 for call, 1 for spawn.
		spawn = 0;
		//Colors for the wheel menu
		color_codes[] = {{0.2,0.2,0.2,0.8}, {0.8,0.8,0.8,1}};
		//Colors for the icon
		icon_color_codes[] = {{0.6,0.6,0.6,0.8}, {1,1,1,0.95}};

	};

	class test_obj_action : base_action
	{
		visible = "";
		condition = "true";
		text = "Test Action";
		function = "test"
	};

	//Put in earplugs
	class earplugs_in : base_action
	{
		visible = "ALWAYS";
		condition = "true";
		text = "STR_VN_QOL_EARPLUGS_IN";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_ear_in_ca.paa";
		icon_highlighted = "";
		arguments = "true";
		function = "vn_mf_fnc_earplugs";
		spawn = 0;
	};

	//Remove earplugs
	class earplugs_out : base_action
	{
		visible = "ALWAYS";
		condition = "true";
		text = "STR_VN_QOL_EARPLUGS_OUT";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_ear_out_ca.paa";
		icon_highlighted = "";
		arguments = "false";
		function = "vn_mf_fnc_earplugs";
		spawn = 0;
	};

	//Join a faction
	class recruiter_join_faction : base_action
	{
		visible = "OBJECT";
		text = $STR_vn_mf_join_faction;
		icon = "";
		icon_highlighted = "";
		arguments = "[_target]"
		function = "an_c_fnc_factions_recruiter_join_faction"
		spawn = 0;
	};

	//Add a sandbag to a building.
	class add_sandbag : base_action
	{
		visible = "ALWAYS";
		condition = "_target call para_g_fnc_is_resupply";
		text = $STR_vn_mf_add_sandbag;
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_resupply_ca.paa";
		icon_highlighted = "";
		arguments = "_target";
		function = "para_c_fnc_resupply_building_with_sandbag";
		spawn = 0;
	};

	//Resupply a building with a crate
	class resupply : base_action
	{
		visible = "ALWAYS";
		condition = "_target call para_g_fnc_is_resupply";
		text = $STR_vn_mf_resupply;
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_resupply_ca.paa";
		icon_highlighted = "";
		arguments = "_target";
		function = "para_c_fnc_resupply_building_with_crate";
		spawn = 0;
	};
};