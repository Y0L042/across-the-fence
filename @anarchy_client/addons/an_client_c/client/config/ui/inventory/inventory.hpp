#define TILES_X 8	//fixed width of 8
#define TILES_Y 16
#define WIDTH 8		//width of complete inventory slots
#define TILE_W (WIDTH/TILES_X)
#define HEIGHT (TILE_W * TILES_Y)
#define TILE_H (HEIGHT/TILES_Y)

// Main Weapon
#define EQUIP_SLOT_WPN_ROWS 2
#define EQUIP_SLOT_WPN_COLS EQUIP_SLOT_WPN_ROWS * 2
// Seconday (Handgun)
#define EQUIP_SLOT_SEC_ROWS 2
#define EQUIP_SLOT_SEC_COLS EQUIP_SLOT_SEC_ROWS * 2
// Uniform
#define EQUIP_SLOT_UNI_COLS 3	// <--- !!! COLS !!!
#define EQUIP_SLOT_UNI_ROWS (EQUIP_SLOT_UNI_COLS * 1.5)
// Vest
#define EQUIP_SLOT_VST_ROWS 3
#define EQUIP_SLOT_VST_COLS EQUIP_SLOT_VST_ROWS
// Backpack
#define EQUIP_SLOT_BKP_ROWS 3
#define EQUIP_SLOT_BKP_COLS EQUIP_SLOT_BKP_ROWS

// Helmet
#define EQUIP_SLOT_HEL_ROWS 2
#define EQUIP_SLOT_HEL_COLS EQUIP_SLOT_HEL_ROWS
// Goggles/Glasses/Balaclava
#define EQUIP_SLOT_GOG_ROWS 2
#define EQUIP_SLOT_GOG_COLS EQUIP_SLOT_GOG_ROWS
// Binonucular
#define EQUIP_SLOT_BIN_ROWS 2
#define EQUIP_SLOT_BIN_COLS EQUIP_SLOT_BIN_ROWS




// Baseclass for Inventory Area and Grid

#define CREATEINVENTORY(NAME,IDCBASE,IDCGRID, INVBASE_X,INVBASE_Y,INVBASE_W,INVBASE_H, INVGRID_X,INVGRID_Y,INVGRID_W,INVGRID_H) \
class an_##NAME : para_RscControlsGroupNoScrollbarH	\
{	\
	idc = IDCBASE;	\
		\
	x = INVBASE_X;	\
	y = INVBASE_Y;	\
	w = INVBASE_W;	\
	h = INVBASE_H;	\
		\
	onLoad = uinamespace setvariable ['an_##NAME##_area', (_this select 0)];	\
	onUnload = uinamespace setvariable ['an_##NAME##_area', controlNull];	\
		\
	class controls	\
	{	\
		class grid: para_RscControlsGroupNoScrollbarHV	\
		{	\
			idc = IDCGRID;	\
				\
			x = INVGRID_X;	\
			y = INVGRID_Y;	\
			w = INVGRID_W;	\
			h = INVGRID_H;	\
				\
			onLoad = uinamespace setvariable ['an_##NAME##_grid', (_this select 0)];	\
			onUnload = uinamespace setvariable ['an_##NAME##_grid', controlNull];	\
				\
			class controls	\
			{	\
					\
				class bg: para_RscText	\
				{	\
					idc = 99999;	\
						\
					x = INVGRID_X;	\
					y = INVGRID_Y;	\
					w = INVGRID_W;	\
					h = INVGRID_H;	\
						\
					colorText[] = {0.3,0.3,0.3,0.95};	\
					colorBackground[] = {0.3,0.3,0.3,0.95};	\
					text = "";	\
					sizeEx = TXT_M;	\
				};	\
			};	\
		};	\
	};	\
}

#define CREATESLOT(NAME, IDCBASE,IDCGRID, INVBASE_X,INVBASE_Y,INVBASE_W,INVBASE_H, INVGRID_X,INVGRID_Y,INVGRID_W,INVGRID_H) \
class an_##NAME : para_RscControlsGroupNoScrollbarHV	\
{	\
	idc = IDCBASE;	\
		\
	x = INVBASE_X;	\
	y = INVBASE_Y;	\
	w = INVBASE_W;	\
	h = INVBASE_H;	\
		\
	onLoad = uinamespace setvariable ['an_##NAME##_area', (_this select 0)];	\
	onUnload = uinamespace setvariable ['an_##NAME##_area', controlNull];	\
		\
	class controls	\
	{	\
		class grid: para_RscControlsGroupNoScrollbarHV	\
		{	\
			idc = IDCGRID;	\
				\
			x = INVGRID_X;	\
			y = INVGRID_Y;	\
			w = INVGRID_W;	\
			h = INVGRID_H;	\
				\
			onLoad = uinamespace setvariable ['an_##NAME##_grid', (_this select 0)];	\
			onUnload = uinamespace setvariable ['an_##NAME##_grid', controlNull];	\
				\
			class controls\
			{	\
				class bg: para_RscText	\
				{	\
					idc = 99999;	\
					onLoad = "(_this select 0) ctrlEnable false";\
						\
					x = INVGRID_X;	\
					y = INVGRID_Y;	\
					w = INVGRID_W;	\
					h = INVGRID_H;	\
						\
					colorText[] = {0.3,0.3,0.3,0.95};	\
					colorBackground[] = {0.3,0.3,0.3,0.95};	\
					text = "";	\
					sizeEx = TXT_M;	\
				};	\
			};	\
		};	\
	};	\
}



// Backgrounds:
// Player
class tile_bg_an_inv_grid_base: para_RscPictureKeepAspect
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
	
	text = "";
};

#define TILEGRIDBG(NAME,WIDTH,HEIGHT,IMAGE) \
class tile_bg_##NAME : tile_bg_an_inv_grid_base \
{ \
	w = UIW(WIDTH); \
	h = UIH(HEIGHT); \
	text = IMAGE; \
}

// Player (Uniform)
TILEGRIDBG(an_inv_uni_grid,TILE_W,TILE_H,"sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa");
// Vest
TILEGRIDBG(an_inv_vst_grid,TILE_W,TILE_H,"sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa");
// Pouch
TILEGRIDBG(an_inv_pch_grid,TILE_W,TILE_H,"sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa");
// Backpack
TILEGRIDBG(an_inv_bkp_grid,TILE_W,TILE_H,"sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa");

// External
TILEGRIDBG(an_inv_external_grid,TILE_W,TILE_H,"sgd\anarchy\an_client_c\client\config\ui\inventory\data\box.paa");


// Slots:
// P:\a3\ui_f\data\GUI\Rsc\RscDisplayGear
// Weapon Main
TILEGRIDBG(an_slot_wpn_grid,EQUIP_SLOT_WPN_COLS,EQUIP_SLOT_WPN_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gun_gs.paa");
// Weapon Main B
TILEGRIDBG(an_slot_wpn_b_grid,EQUIP_SLOT_WPN_COLS,EQUIP_SLOT_WPN_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gun_gs.paa");
// Secondary / Handgun
TILEGRIDBG(an_slot_sec_grid,EQUIP_SLOT_SEC_COLS,EQUIP_SLOT_SEC_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa");
// Uniform
TILEGRIDBG(an_slot_uni_grid,EQUIP_SLOT_UNI_COLS,EQUIP_SLOT_UNI_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa");
// Vest
TILEGRIDBG(an_slot_vst_grid,EQUIP_SLOT_VST_COLS,EQUIP_SLOT_VST_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_vest_gs.paa");
// Backpack
TILEGRIDBG(an_slot_bkp_grid,EQUIP_SLOT_BKP_COLS,EQUIP_SLOT_BKP_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa");
// Helmet
TILEGRIDBG(an_slot_hel_grid,EQUIP_SLOT_HEL_COLS,EQUIP_SLOT_HEL_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa");
// Goggles/Glasses/Balaclava
TILEGRIDBG(an_slot_gog_grid,EQUIP_SLOT_GOG_COLS,EQUIP_SLOT_GOG_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa");
// Binonucular
TILEGRIDBG(an_slot_bin_grid,EQUIP_SLOT_BIN_COLS,EQUIP_SLOT_BIN_ROWS,"a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa");



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
	onMouseZChanged = "call an_c_fnc_ui_inv_EH_mouse_z";
	
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
		
		// Inventory: External
		// Header Text
		class header_external: para_RscText
		{
			idc = 200;
			
			style = "0x02";
			
			x = UIX_CL(9.65);
			y = UIY_CU(12.5);
			w = UIW(8);
			h = UIH(1.25);
			
			colorText[] = {1,1,1,0.95};
			colorBackground[] = {0.0,0.0,0.0,0.3};
			sizeEx = TXT_M;
			
			text = "External";
			
			onLoad = "uinamespace setvariable [""an_inv_header_external"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_header_external"", controlNull];";
		};
		// Inventory
		CREATEINVENTORY(inv_external,1100,1000, UIX_CL(9.65),UIY_CU(10),UIW(8.65),UIH(20), UIW(0),UIH(0),UIW(WIDTH),UIH(HEIGHT));
		
		// Inventory: Player/Personal
		// Header Text
		class header_personal: header_external
		{
			idc = 100;
			
			x = UIX_CR(1);
			// y = UIY_CU(12.5);
			w = UIW(8);
			h = UIH(1.25);
			
			text = "Personal";
			
			onLoad = "uinamespace setvariable [""an_inv_header_personal"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_header_personal"", controlNull];";
		};
		// Inventory
		CREATEINVENTORY(inv_uni,1112,1012, UIX_CR(1),UIY_CU(10),UIW(8.65),UIH(20), UIW(0),UIH(0),UIW(WIDTH),UIH(HEIGHT));
		CREATEINVENTORY(inv_vst,1113,1013, UIX_CL(10),UIY_CD(11),UIW(8.65),UIH((TILE_W * 5)), UIW(0),UIH(0),UIW(WIDTH),UIH((TILE_W * 6)));
		CREATEINVENTORY(inv_pch,1114,1014, UIX_CR(0),UIY_CD(11),UIW(8.65),UIH((TILE_W * 5)), UIW(0),UIH(0),UIW(WIDTH),UIH((TILE_W * 6)));
		CREATEINVENTORY(inv_bkp,1115,1015, UIX_CR(10),UIY_CD(11),UIW(8.65),UIH((TILE_W * 5)), UIW(0),UIH(0),UIW(WIDTH),UIH((TILE_W * 6)));
		
		/////////////////////////// EQUIP SLOTS:
		// Header Text - Equipment
		class header_equipment: header_external
		{
			idc = 300;
			
			x = UIX_CR(10);
			// y = UIY_CU(12.5);
			w = UIW(11);
			h = UIH(1.25);
			
			text = "Equipment";
			
			onLoad = "uinamespace setvariable [""an_inv_header_equipment"", (_this#0)];";
			onUnload = "uinamespace setvariable [""an_inv_header_equipment"", controlNull];";
		};
		
		// Inventory: Slot: Weapon - Active
		CREATESLOT(slot_wpn, 2102,2002, UIX_CR(10),UIY_CU(10),UIW(EQUIP_SLOT_WPN_COLS),UIH(EQUIP_SLOT_WPN_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_WPN_COLS),UIH(EQUIP_SLOT_WPN_ROWS));
		
		// Inventory: Slot: Weapon - Second (on the back)
		CREATESLOT(slot_wpn_b, 2302,2202, UIX_CR(10),UIY_CU((10-(EQUIP_SLOT_WPN_ROWS+0.5))),UIW(EQUIP_SLOT_WPN_COLS),UIH(EQUIP_SLOT_WPN_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_WPN_COLS),UIH(EQUIP_SLOT_WPN_ROWS));
		
		// Inventory: Slot: Secondary
		CREATESLOT(slot_sec, 2103,2003, UIX_CR((10 + EQUIP_SLOT_WPN_COLS + 0.5)),UIY_CU(10),UIW(EQUIP_SLOT_SEC_COLS),UIH(EQUIP_SLOT_SEC_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_SEC_COLS),UIH(EQUIP_SLOT_SEC_ROWS));
		
		
		// Inventory: Slot: Uniform
		CREATESLOT(slot_uni, 2112,2012, UIX_CR(10),UIY_CU(5),UIW(EQUIP_SLOT_UNI_COLS),UIH(EQUIP_SLOT_UNI_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_UNI_COLS),UIH(EQUIP_SLOT_UNI_ROWS));
		
		// Inventory: Slot: Vest
		CREATESLOT(slot_vst, 2113,2013, UIX_CR(10),UIY_CU((5-EQUIP_SLOT_UNI_ROWS-0.5)),UIW(EQUIP_SLOT_VST_COLS),UIH(EQUIP_SLOT_VST_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_VST_COLS),UIH(EQUIP_SLOT_VST_ROWS));
		
		// Inventory: Slot: Backpack
		CREATESLOT(slot_bkp, 2115,2015, UIX_CR(10),UIY_CU((5-EQUIP_SLOT_UNI_ROWS-EQUIP_SLOT_VST_ROWS-1)),UIW(EQUIP_SLOT_BKP_COLS),UIH(EQUIP_SLOT_BKP_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_BKP_COLS),UIH(EQUIP_SLOT_BKP_ROWS));
		
		
		// Inventory: Slot: Helmet
		CREATESLOT(slot_hel, 2110,2010, UIX_CR((10+EQUIP_SLOT_UNI_COLS+0.5)),UIY_CU(5),UIW(EQUIP_SLOT_HEL_COLS),UIH(EQUIP_SLOT_HEL_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_HEL_COLS),UIH(EQUIP_SLOT_HEL_ROWS));
		
		// Inventory: Slot: Goggles
		CREATESLOT(slot_gog, 2111,2011, UIX_CR((10+EQUIP_SLOT_UNI_COLS+0.5)),UIY_CU((5-EQUIP_SLOT_HEL_ROWS-0.5)),UIW(EQUIP_SLOT_GOG_COLS),UIH(EQUIP_SLOT_GOG_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_GOG_COLS),UIH(EQUIP_SLOT_GOG_ROWS));
		
		// Inventory: Slot: Binonucular
		CREATESLOT(slot_bin, 2117,2017, UIX_CR((10+EQUIP_SLOT_UNI_COLS+0.5)),UIY_CU((5-EQUIP_SLOT_HEL_ROWS-EQUIP_SLOT_GOG_ROWS-1)),UIW(EQUIP_SLOT_BIN_COLS),UIH(EQUIP_SLOT_BIN_ROWS), UIW(0),UIH(0),UIW(EQUIP_SLOT_BIN_COLS),UIH(EQUIP_SLOT_BIN_ROWS));
	};
};
