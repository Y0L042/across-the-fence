class CfgPatches
{
	class sgd_anarchy_client
	{
		author = "Savage Game Design";
		name = "Anarchy Client";
		url = "https://www.arma3.com";
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"sgd_paradigm"};
	};
};


class CfgFunctions
{
	class AN_C
	{
		// DEV: Disabled until paradigm is set up properly
		// #include "..\paradigm\an_server\functions.hpp"
		#include "client\functions\functions_c.h"
	};

	class AN_G
	{
		#include "global\functions\functions_g.h"
	};
};

//// UI
class para_RscText;
class para_RscPicture;
class para_RscPictureKeepAspect;
class para_RscStructuredText;
class para_RscStructuredText_c;
class para_RscStructuredText_r;
class para_RscListNBox;
class para_RscListBox;
class para_RscButton;
class para_RscButton_ImgSwitch;
class para_RscControlsGroup;
class para_RscControlsGroupNoScrollbarHV;
class para_RscControlsGroupNoScrollbarH;
class para_RscControlsGroupNoScrollbarV;
class para_RscCombo;
class para_RscMapControl;
class para_RscShortcutButton;
class para_RscButtonMenu;
class para_RscEdit;
class ScrollBar;	// ToDo: Define "para_scrollBar"
class para_RscCheckBoxes;
class para_ControlsTable;
class para_RscProgress;
class para_RscStatProgress;
class para_RscStatProgressHUD;

//UI Defines
#include "\sgd\paradigm\client\configs\ui\ui_def_base.inc"

