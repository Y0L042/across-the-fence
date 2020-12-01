#define TILES_X 8	//fixed width of 8
#define TILES_Y 16
#define WIDTH 8		//width of complete inventory slots
#define TILE_W (WIDTH/TILES_X)
#define HEIGHT (TILE_W * TILES_Y)
#define TILE_H (HEIGHT/TILES_Y)

// Main Weapon
// #define EQUIP_SLOT_WPN_ROWS 3
// #define EQUIP_SLOT_WPN_COLS 6
#define EQUIP_SLOT_WPN_ROWS 2
#define EQUIP_SLOT_WPN_COLS EQUIP_SLOT_WPN_ROWS * 2
// Seconday (Handgun)
// #define EQUIP_SLOT_SEC_ROWS 2
// #define EQUIP_SLOT_SEC_COLS 4
#define EQUIP_SLOT_SEC_ROWS 2
#define EQUIP_SLOT_SEC_COLS EQUIP_SLOT_SEC_ROWS * 2
// Uniform
// #define EQUIP_SLOT_UNI_ROWS 6
// #define EQUIP_SLOT_UNI_COLS 4
#define EQUIP_SLOT_UNI_ROWS 3
#define EQUIP_SLOT_UNI_COLS (EQUIP_SLOT_UNI_ROWS / 1.5)
// Vest
// #define EQUIP_SLOT_VST_ROWS 4
// #define EQUIP_SLOT_VST_COLS 4
#define EQUIP_SLOT_VST_ROWS 2
#define EQUIP_SLOT_VST_COLS EQUIP_SLOT_VST_ROWS
// Backup
// #define EQUIP_SLOT_BKP_ROWS 4
// #define EQUIP_SLOT_BKP_COLS 4
#define EQUIP_SLOT_BKP_ROWS 2
#define EQUIP_SLOT_BKP_COLS EQUIP_SLOT_BKP_ROWS
// Helmet
// #define EQUIP_SLOT_HEL_ROWS 3
// #define EQUIP_SLOT_HEL_COLS 3
#define EQUIP_SLOT_HEL_ROWS 2
#define EQUIP_SLOT_HEL_COLS EQUIP_SLOT_HEL_ROWS

// Backgrounds:
// Player
// class tile_bg_an_inv_player_grid: para_RscPicture
class tile_bg_an_inv_player_grid: para_RscPictureKeepAspect
{
	idc = -1;
	type = 0;

	style = 48;	//normal Picture (stretching)
	// style = 48 + 2048;	//keepAspectRatio	-	NOT USED! Big wobble wobble
	
	x = 0;
	y = 0;
	w = UIW(TILE_W);
	h = UIH(TILE_H);
	
	colorText[] = {0.2,0.2,0.2,1};
	colorBackground[] = {1,1,1,1};
	
	sizeEx = TXT_M;
	font = USEDFONT;
	
	text = "sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa";
};
// External
class tile_bg_an_inv_external_grid: tile_bg_an_inv_player_grid
{
	// in case of chaning to a different Background image or color scheme
	text = "sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa";
};

// Slots:
// P:\a3\ui_f\data\GUI\Rsc\RscDisplayGear
// Weapon Main
class tile_bg_an_slot_wpn_grid: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_WPN_COLS);
	h = UIH(EQUIP_SLOT_WPN_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gun_gs.paa";
};
// Weapon Main B
class tile_bg_an_slot_wpn_grid_b: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_WPN_COLS);
	h = UIH(EQUIP_SLOT_WPN_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gun_gs.paa";
};
// Secondary / Handgun
class tile_bg_an_slot_sec_grid: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_SEC_COLS);
	h = UIH(EQUIP_SLOT_SEC_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa";
};
// Uniform
class tile_bg_an_slot_uni_grid: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_UNI_COLS);
	h = UIH(EQUIP_SLOT_UNI_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa";
};
// Vest
class tile_bg_an_slot_vst_grid: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_VST_COLS);
	h = UIH(EQUIP_SLOT_VST_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_vest_gs.paa";
};
// Helmet
class tile_bg_an_slot_hel_grid: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_HEL_COLS);
	h = UIH(EQUIP_SLOT_HEL_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa";
};
// Backpack
class tile_bg_an_slot_bkp_grid: tile_bg_an_inv_player_grid
{
	w = UIW(EQUIP_SLOT_BKP_COLS);
	h = UIH(EQUIP_SLOT_BKP_ROWS);
	text = "a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa";
};


class inv_icon: para_RscControlsGroupNoScrollbarHV
{
	idc = 1000;
	
	x = 0;
	y = 0;
	w = UIW((WIDTH*8));
	h = UIH((HEIGHT*3));
	
	// onMouseButtonDown	= "";
	onMouseButtonUp		= "_this call an_c_fnc_ui_inv_item_grab;";
	// onMouseButtonClick = "";	//Delay, not rly usable - Triggers while holding MB
	// onMouseButtonDblClick	= "";	//triggers immediately after 2nd MB-Down (before UP)
	
	class controls
	{
		class bg: para_RscText	//ToDo: Exchange with Picture + frame + color frame depending on calculated rarity
		{
			idc = 100;
			
			x = 0;
			y = 0;
			w = UIW(TILE_W);	//final size will be defined in function
			h = UIH(TILE_H);	//final size will be defined in function
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0.0,0.2};
			text = "";
			sizeEx = TXT_M;
		};
		
 		class icon: para_RscPicture
		{
			idc = 200;
			type = 0;
			style = 48;	//normal Picture (stretching)
			
			x = 0;
			y = 0;
			w = UIW(TILE_W);	//final size will be defined in function
			h = UIH(TILE_H);	//final size will be defined in function
			
			text = "";	//Will be defined in function
			
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,0};
			
			
			sizeEx = TXT_M;
			font = USEDFONT;
		};
	};
};


class an_inventory
{
	idd = 1074;
	name = "an_inventory";
	
	movingEnable = 0;
	enableSimulation = 1;
	
	onLoad = "[""onLoad"",_this,""an_inventory"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay');";
	onUnload = "[""onUnload"",_this,""an_inventory"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay'); call an_c_fnc_ui_inv_item_drop_check;";
	
	// KeyDown: block every button (movement)
	onKeyDown = " if(_this#1 in [1])then{_this#0 closeDisplay 1;}; true ";
	// KeyUp: block every button (movement), except ESC/TAB/G button to close the Inv
	onKeyUp = " if(_this#1 in [15,34])then{_this#0 closeDisplay 1;}; true ";
	// Handle scrolling the Mousewheel (only if an item is currently grabbed)
	onMouseZChanged ="call an_c_fnc_ui_inv_EH_mouse_z";
	
	onMouseButtonDown	= "";
	onMouseButtonUp		= "";
	// onMouseMoving = "";		//"USELESS" ON A DISPLAY! Doesn't return X and Y Pos, just "distance from xy to xy during specific time/FPS (??)"
	// onMouseZChanged = "";
	
	class controlsBackground
	{
		class bg: para_RscText	//ToDo: Exchange with Picture + frame + color frame depending on calculated rarity
		{
			idc = -1;
			
			x = safezoneX;
			y = safezoneY;
			w = safeZoneW;
			h = safeZoneH;
			
			colorText[] = {0.0,0.0,0.0,0.0};
			colorBackground[] = {0.2,0.2,0.2,0.4};
			text = "";
			sizeEx = TXT_M;
		};
	};
	
	class Controls
	{
		// Inventory: Player/Personal
		// Header Text
		class header_personal: para_RscText
		{
			idc = 100;
			
			x = UIX_CR(1);
			y = UIY_CU(11.5);
			w = UIW(8);
			h = UIH(1.25);
			
			colorText[] = {1,1,1,0.95};
			colorBackground[] = {0.0,0.0,0.0,0.3};
			text = "Personal";
			sizeEx = TXT_M;
			
			style = "0x02";
			
			onLoad = "uinamespace setvariable [""an_inv_header_personal"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_header_personal"", controlNull];";
		};
		// Inventory
		class grid_player_area: para_RscControlsGroupNoScrollbarH
		{
			idc = 1100;
			
			x = UIX_CR(1);
			y = UIY_CU(10);
			w = UIW(8.65);
			h = UIH(20);
			
			onLoad = "uinamespace setvariable [""an_inv_player_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_player_area"", controlNull];";
			
			
			onMouseButtonDown	= "";
			onMouseButtonUp		= "";
			// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
			// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 1000;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(WIDTH);
					h = UIH(HEIGHT);
					
					onLoad = "uinamespace setvariable [""an_inv_player_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_inv_player_grid"", controlNull];";
					
					// onMouseButtonDown	= "";		//RESERVED: "grab" Item
					// onMouseButtonUp		= "";
					// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
					// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(WIDTH);
							h = UIH(HEIGHT);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		// Inventory: External
		// Header Text
		class header_external: header_personal
		{
			idc = 200;
			
			x = UIX_CL(9.65);
			y = UIY_CU(11.5);
			w = UIW(8);
			h = UIH(1.25);
			
			text = "External";
			
			onLoad = "uinamespace setvariable [""an_inv_header_external"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_header_external"", controlNull];";
		};
		// Inventory
		class grid_crate_area: para_RscControlsGroupNoScrollbarH
		{
			idc = 1101;
			
			x = UIX_CL(9.65);
			y = UIY_CU(10);
			w = UIW(8.65);
			h = UIH(20);
			
			
			onLoad = "uinamespace setvariable [""an_inv_external_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_external_area"", controlNull];";
			
			
			onMouseButtonDown	= "";
			onMouseButtonUp		= "";
			// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
			// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 1001;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(WIDTH);
					h = UIH(SLOT_H);
					
					onLoad = "uinamespace setvariable [""an_inv_external_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_inv_external_grid"", controlNull];";
					
					// onMouseButtonDown	= "";		//RESERVED: "grab" Item
					// onMouseButtonUp		= "";
					// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
					// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(WIDTH);
							h = UIH(HEIGHT);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		/////////////////////////// EQUIP SLOTS:
		// Header Text - Equipment
		class header_equipment: header_personal
		{
			idc = 300;
			
			x = UIX_CR(10);
			y = UIY_CU(11.5);
			w = UIW(11);
			h = UIH(1.25);
			
			text = "Equipment";
			
			onLoad = "uinamespace setvariable [""an_inv_header_equipment"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_header_equipment"", controlNull];";
		};
		
		// Inventory: Slot: Weapon
		class grid_wpn_area: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2102;
			
			x = UIX_CR(10);
			y = UIY_CU(10);
			w = UIW(EQUIP_SLOT_WPN_COLS);
			h = UIH(EQUIP_SLOT_WPN_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_wpn_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_wpn_area"", controlNull];";
			
			onMouseButtonDown	= "";
			onMouseButtonUp		= "";
			// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
			// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2002;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_WPN_COLS);
					h = UIH(EQUIP_SLOT_WPN_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_wpn_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_wpn_grid"", controlNull];";
					
					// onMouseButtonDown	= "";		//RESERVED: "grab" Item
					// onMouseButtonUp		= "";
					// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
					// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_WPN_COLS);
							h = UIH(EQUIP_SLOT_WPN_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		class grid_wpn_area_b: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2302;
			
			x = UIX_CR(10);
			y = UIY_CU((10-(EQUIP_SLOT_WPN_ROWS+0.5)));
			w = UIW(EQUIP_SLOT_WPN_COLS);
			h = UIH(EQUIP_SLOT_WPN_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_wpn_area_b"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_wpn_area_b"", controlNull];";
			
			onMouseButtonDown	= "";
			onMouseButtonUp		= "";
			// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
			// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2202;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_WPN_COLS);
					h = UIH(EQUIP_SLOT_WPN_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_wpn_grid_b"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_wpn_grid_b"", controlNull];";
					
					// onMouseButtonDown	= "";		//RESERVED: "grab" Item
					// onMouseButtonUp		= "";
					// onMouseMoving = "";		//DO NOT USE! Buggy (not detecting reliably)
					// onMouseZChanged = "";	//DO NOT USE! Buggy (not detecting reliably)
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_WPN_COLS);
							h = UIH(EQUIP_SLOT_WPN_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		// Inventory: Slot: Uniform
		class grid_uni_area: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2112;
			
			x = UIX_CR(10);
			y = UIY_CU(5);
			w = UIW(EQUIP_SLOT_UNI_COLS);
			h = UIH(EQUIP_SLOT_UNI_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_uni_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_uni_area"", controlNull];";
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2012;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_UNI_COLS);
					h = UIH(EQUIP_SLOT_UNI_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_uni_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_uni_grid"", controlNull];";
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_UNI_COLS);
							h = UIH(EQUIP_SLOT_UNI_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		
		// Inventory: Slot: Vest
		class grid_vst_area: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2113;
			
			x = UIX_CR(10);
			y = UIY_CD(1);
			w = UIW(EQUIP_SLOT_VST_COLS);
			h = UIH(EQUIP_SLOT_VST_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_vst_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_vst_area"", controlNull];";
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2013;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_VST_COLS);
					h = UIH(EQUIP_SLOT_VST_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_vst_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_vst_grid"", controlNull];";
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_VST_COLS);
							h = UIH(EQUIP_SLOT_VST_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		// Inventory: Slot: Helmet
		class grid_hel_area: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2110;
			
			x = UIX_CR(15);
			y = UIY_CU(6);
			w = UIW(EQUIP_SLOT_HEL_COLS);
			h = UIH(EQUIP_SLOT_HEL_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_hel_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_hel_area"", controlNull];";
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2010;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_HEL_COLS);
					h = UIH(EQUIP_SLOT_HEL_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_hel_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_hel_grid"", controlNull];";
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_HEL_COLS);
							h = UIH(EQUIP_SLOT_HEL_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		
		// Inventory: Slot: Backpack
		class grid_bkp_area: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2115;
			
			x = UIX_CR(15);
			y = UIY_CU(2);
			w = UIW(EQUIP_SLOT_BKP_COLS);
			h = UIH(EQUIP_SLOT_BKP_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_bkp_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_bkp_area"", controlNull];";
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2015;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_BKP_COLS);
					h = UIH(EQUIP_SLOT_BKP_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_bkp_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_bkp_grid"", controlNull];";
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_BKP_COLS);
							h = UIH(EQUIP_SLOT_BKP_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
		
		// Inventory: Slot: Backpack
		class grid_sec_area: para_RscControlsGroupNoScrollbarHV
		{
			idc = 2103;
			
			x = UIX_CR(17);
			y = UIY_CU(10);
			w = UIW(EQUIP_SLOT_SEC_COLS);
			h = UIH(EQUIP_SLOT_SEC_ROWS);
			
			onLoad = "uinamespace setvariable [""an_slot_sec_area"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_slot_sec_area"", controlNull];";
			
			class controls
			{
				class grid: para_RscControlsGroupNoScrollbarHV
				{
					idc = 2003;
					
					x = UIW(0);
					y = UIH(0);
					w = UIW(EQUIP_SLOT_SEC_COLS);
					h = UIH(EQUIP_SLOT_SEC_ROWS);
					
					onLoad = "uinamespace setvariable [""an_slot_sec_grid"", (_this#0)];";
					onUnload = "uinamespace setvariable [""an_slot_sec_grid"", controlNull];";
					
					class controls
					{
						
						class bg: para_RscText
						{
							idc = 99999;
							
							x = 0;
							y = 0;
							w = UIW(EQUIP_SLOT_SEC_COLS);
							h = UIH(EQUIP_SLOT_SEC_ROWS);
							
							colorText[] = {0.3,0.3,0.3,0.95};
							colorBackground[] = {0.3,0.3,0.3,0.95};
							text = "";
							sizeEx = TXT_M;
						};
					};
				};
			};
		};
		
	};
};
