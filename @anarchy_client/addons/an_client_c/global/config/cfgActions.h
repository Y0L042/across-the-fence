
class CfgActions
{
	class None;
	class TeamSwitch: None
	{
		show = 0;
	};
	class Gear: None
	{
		priority = 5.1;
		showWindow = 0;
		show = 0;
		shortcut = "Gear";
		text = "$STR_ACTION_GEAR";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\gear_ca.paa' size='2.5' shadow=2 />";
	};
	class GearOpen: None
	{
		priority = 5.1;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_GEAROPEN";
		textDefault = "$STR_ACTION_GEAROPEN";
	};
	class OpenBag: None
	{
		priority = 5.2;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_OPEN_BAG";
		textDefault = "$STR_ACTION_OPEN_BAG";
	};
	class TakeBag: None
	{
		priority = 5.3;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_TAKE_BAG";
		textDefault = "$STR_ACTION_TAKE_BAG";
	};
	class PutBag: None
	{
		priority = 5.2;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_DROP_BAG";
		textDefault = "$STR_ACTION_DROP_BAG";
	};
	class DropBag: None
	{
		priority = 5.2;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_DROP_BAG";
		textDefault = "$STR_ACTION_DROP_BAG";
	};
	class AddBag: None
	{
		priority = 5.3;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_TAKE_BAG";
		textDefault = "$STR_ACTION_TAKE_BAG";
	};
	class NVGoggles: None
	{
		showWindow = 0;
		show = 0;
	};
	class NVGogglesOff: NVGoggles
	{
		showWindow = 0;
		show = 0;
	};
	class GetOut: None
	{
		priority = 6.2;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getout_ca.paa' size='1.8' shadow=2 />";
	};
	class Eject: None
	{
		priority = 6.1;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\eject_ca.paa' size='1.8' shadow=2 />";
	};
	class LoadVehicle: None
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_ACTION_LOAD_VEHICLE";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa' size='1.8' shadow=2 />";
	};
	class UnloadVehicle: None
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_ACTION_UNLOAD_VEHICLE";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\unloadVehicle_ca.paa' size='1.8' shadow=2 />";
	};
	class UnloadAllVehicles: None
	{
		priority = 3;
		text = "$STR_A3_ACTION_UNLOAD_ALL_VEHICLES";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\unloadAllVehicles_ca.paa' size='1.8' shadow=2 />";
	};
	class LadderOnUp: None
	{
		priority = 8;
		showWindow = 1;
		show = 1;
		radius = 2;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ladderup_ca.paa' size='1.8' shadow=2 />";
	};
	class LadderOnDown: None
	{
		priority = 8;
		showWindow = 1;
		show = 1;
		radius = 2;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa' size='1.8' shadow=2 />";
	};
	class LadderOff: None
	{
		priority = 5;
		showWindow = 1;
		show = 1;
		radius = 2;
		text = "$STR_ACTION_LADDEROFF";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ladderoff_ca.paa' size='1.8' shadow=2 />";
	};
	class MoveToDriver: None
	{
		priority = 1.1;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getindriver_ca.paa' size='1.8' shadow=2 />";
	};
	class MoveToPilot: MoveToDriver
	{
		priority = 1.2;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getinpilot_ca.paa' size='1.8' shadow=2 />";
	};
	class MoveToGunner: None
	{
		priority = 1.5;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getingunner_ca.paa' size='1.8' shadow=2 />";
	};
	class MoveToCommander: None
	{
		priority = 1.4;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getincommander_ca.paa' size='1.8' shadow=2 />";
	};
	class MoveToCargo: None
	{
		priority = 1;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getincargo_ca.paa' size='1.8' shadow=2 />";
	};
	class MoveToTurret: None
	{
		showWindow = 0;
		show = 1;
		priority = 1.3;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getingunner_ca.paa' size='1.8' shadow=2 />";
	};
	class LoadMagazine: None	// was already disabled
	{
		priority = 2;
		showWindow = 0;
		show = 0;
	};
	class LoadOtherMagazine: LoadMagazine	// TODO: Check if Vehicle
	{
		priority = 2;
		showWindow = 0;
		show = 1;
	};
	class LoadEmptyMagazine: LoadMagazine	// TODO: Check if Vehicle
	{
		priority = 2.1;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\reload_ca.paa' size='1.8' shadow=2 />";
	};
	class TakeVehicleControl: None
	{
		priority = 8;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_TAKE_CONTROL";
		textDefault = "$STR_ACTION_TAKE_CONTROL";
	};
	class SuspendVehicleControl: None
	{
		priority = 7;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_SUSPEND_CONTROL";
		textDefault = "$STR_ACTION_SUSPEND_CONTROL";
	};
	class LockVehicleControl: None
	{
		priority = 7;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_LOCK_CONTROL";
		textDefault = "$STR_ACTION_LOCK_CONTROL";
	};
	class UnlockVehicleControl: None
	{
		priority = 7;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_UNLOCK_CONTROL";
		textDefault = "$STR_ACTION_UNLOCK_CONTROL";
	};
	class SwitchWeapon: None
	{
		priority = 3.1;
		showWindow = 0;
		show = 0;
		shortcut = "SwitchWeapon";
		text = "$STR_ACTION_WEAPON";
		textDefault = "$STR_ACTION_WEAPON";
		hideActions[] = {"SwitchSecondary"};
	};
	class SwitchMagazine: SwitchWeapon
	{
		showWindow = 0;
		show = 0;
		shortcut = "ReloadMagazine";
	};
	class HideWeapon: SwitchWeapon
	{
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_HIDE_WEAPON";
		textDefault = "$STR_ACTION_HIDE_WEAPON";
	};
	class UseWeapon: None
	{
		priority = 1.2;
		showWindow = 0;
		show = 0;
		text = "%1";
		textDefault = "%1";
	};
	class HandGunOn: None
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_WEAPON";
		textDefault = "$STR_ACTION_WEAPON";
		hideActions[] = {"SwitchHandGun"};
	};
	class HandGunOnStand: HandGunOn
	{
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_WEAPONINHAND";
		textDefault = "$STR_ACTION_WEAPONINHAND";
	};
	class HandGunOff: None
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_WEAPON";
		textDefault = "$STR_ACTION_WEAPON";
		hideActions[] = {"SwitchPrimary"};
	};
	class HandGunOffStand: HandGunOff
	{
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_WEAPONINHAND";
		textDefault = "$STR_ACTION_WEAPONINHAND";
	};
	class EngineOn: None
	{
		priority = 6;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\engine_on_ca.paa' size='1.8' shadow=2 />";
	};
	class EngineOff: None
	{
		priority = 6;
		showWindow = 0;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\engine_off_ca.paa' size='1.8' shadow=2 />";
	};
	class GetInCommander: None
	{
		priority = 5.9;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getincommander_ca.paa' size='1.8' shadow=2 />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInDriver: None
	{
		priority = 5.8;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getindriver_ca.paa' size='1.8' shadow=2 />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInPilot: None
	{
		priority = 5.6;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getinpilot_ca.paa' size='1.8' shadow=2 />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInGunner: None
	{
		priority = 5.7;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getingunner_ca.paa' size='1.8' shadow=2 />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInCargo: None
	{
		priority = 5.5;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getincargo_ca.paa' size='1.8' shadow=2 />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInTurret: None
	{
		priority = 5.4;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\getingunner_ca.paa' size='1.8' shadow=2 />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class Repair: None
	{
		priority = 6;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\repair_ca.paa' size='1.8' shadow=2 />";
	};
	class Rearm: None
	{
		priority = 5.1;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\reammo_ca.paa' size='1.8' shadow=2 />";
	};
	class Refuel: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\refuel_ca.paa' size='1.8' shadow=2 />";
	};
	class Heal: None
	{
		priority = 10;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_Heal0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\heal_ca.paa' size='1.8' shadow=2 />";
	};
	class HealSoldier: None
	{
		priority = 10;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_HealSoldier0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\heal_ca.paa' size='1.8' shadow=2 />";
	};
	class FirstAid: None
	{
		priority = 10;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\heal_ca.paa' size='1.8' shadow=2 />";
	};
	class RepairVehicle: None
	{
		priority = 9;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\repair_ca.paa' size='1.8' shadow=2 />";
	};
	class Sleep: None		// ToDo: dafuq is that? Old Man?
	{
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_Sleep0";
	};
	class WakeUp: None		// ToDo: dafuq is that? Old Man?
	{
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_WakeUp0";
	};
	class UnmountItem: None		// ToDo: dafuq is that?
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnmountItem0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class MountItem: None		// ToDo: dafuq is that?
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_MountItem0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class DropItem: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_DropItem0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class TakeItem: None
	{
		priority = 5.3;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_TakeItem0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' size='1.8' shadow=2 />";
	};
	class UnloadMagazine: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadMagazine0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class ChangeUniformWithBody: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_ChangeUniformWithBody0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class DropItemFromBody: None
	{
		priority = 4;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_DropItemFromBody0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class TakeItemFromBody: None
	{
		priority = 5.3;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_TakeItemFromBody0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class ChangeBackpackFromBackpack: None
	{
		priority = 4;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_ChangeBackpackFromBackpack0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class TakeWeaponFromBody: None
	{
		priority = 5;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_TakeWeaponFromBody0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class TakeBackpackFromBody: None
	{
		priority = 5;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_TakeBackpackFromBody0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class UnmountUniformItem: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnmountUniformItem0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class MountUniformItem: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_MountUniformItem0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class MountWeaponFromInv: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_MountWeaponFromInv0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class UnmountWeaponToInv: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnmountWeaponToInv0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa' size='2.5' shadow=0 />";
	};
	class UnloadUnconsciousUnits: None
	{
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_UnloadIncapacitated";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\unloadIncapacitated_ca.paa' size='3' shadow='2' />";
	};
	class ActiveSensorsOn: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		shortcut = "ActiveSensorsToggle";
		text = "$STR_ACTION_SENSORS_ON";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\RadarOn_ca.paa' size='1.8' shadow=2 />";
		hideActions[] = {"ActiveSensorsToggle"};
	};
	class ActiveSensorsOff: ActiveSensorsOn
	{
		text = "$STR_ACTION_SENSORS_OFF";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\RadarOff_ca.paa' size='1.8' shadow=2 />";
	};
	class ListRightVehicleDisplay: None
	{
		priority = 1;
		showWindow = 0;
		show = 0;
		shortcut = "ListRightVehicleDisplay";
		hideOnUse = 0;
		text = "$STR_ACTION_CUSTOMINFO_RIGHT_NEXT";
		textDefault = "$STR_ACTION_CUSTOMINFO_RIGHT_NEXT";
		hideActions[] = {"ListRightVehicleDisplay"};
	};
	class ListLeftVehicleDisplay: ListRightVehicleDisplay
	{
		shortcut = "ListLeftVehicleDisplay";
		text = "$STR_ACTION_CUSTOMINFO_LEFT_NEXT";
		textDefault = "$STR_ACTION_CUSTOMINFO_LEFT_NEXT";
		hideActions[] = {"ListLeftVehicleDisplay"};
	};
	class ListPrevRightVehicleDisplay: None
	{
		showWindow = 0;
		show = 0;
		hideOnUse = 0;
		shortcut = "ListPrevRightVehicleDisplay";
		text = "$STR_ACTION_CUSTOMINFO_RIGHT_PREV";
		textDefault = "$STR_ACTION_CUSTOMINFO_RIGHT_PREV";
		hideActions[] = {"ListPrevRightVehicleDisplay"};
	};
	class ListPrevLeftVehicleDisplay: ListPrevRightVehicleDisplay
	{
		shortcut = "ListPrevLeftVehicleDisplay";
		text = "$STR_ACTION_CUSTOMINFO_LEFT_PREV";
		textDefault = "$STR_ACTION_CUSTOMINFO_LEFT_PREV";
		hideActions[] = {"ListPrevLeftVehicleDisplay"};
	};
	class CloseRightVehicleDisplay: None
	{
		showWindow = 0;
		show = 0;
		shortcut = "CloseRightVehicleDisplay";
		text = "$STR_ACTION_CUSTOMINFO_RIGHT_CLOSE";
		textDefault = "$STR_ACTION_CUSTOMINFO_RIGHT_CLOSE";
		hideActions[] = {"CloseRightVehicleDisplay"};
	};
	class CloseLeftVehicleDisplay: CloseRightVehicleDisplay
	{
		shortcut = "CloseLeftVehicleDisplay";
		text = "$STR_ACTION_CUSTOMINFO_LEFT_CLOSE";
		textDefault = "$STR_ACTION_CUSTOMINFO_LEFT_CLOSE";
		hideActions[] = {"CloseLeftVehicleDisplay"};
	};
	class NextModeRightVehicleDisplay: None
	{
		priority = 0.9;
		showWindow = 0;
		show = 0;
		shortcut = "NextModeRightVehicleDisplay";
		hideOnUse = 0;
		text = "$STR_ACTION_CUSTOMINFO_RIGHT_MODE";
		textDefault = "$STR_ACTION_CUSTOMINFO_RIGHT_MODE";
		hideActions[] = {"NextModeRightVehicleDisplay"};
	};
	class NextModeLeftVehicleDisplay: NextModeRightVehicleDisplay
	{
		shortcut = "NextModeLeftVehicleDisplay";
		text = "$STR_ACTION_CUSTOMINFO_LEFT_MODE";
		textDefault = "$STR_ACTION_CUSTOMINFO_LEFT_MODE";
		hideActions[] = {"NextModeLeftVehicleDisplay"};
	};
	class TakeWeapon: None
	{
		priority = 5.3;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' size='1.8' shadow=2 />";
	};
	class TakeMagazine: None
	{
		priority = 5.3;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' size='1.8' shadow=2 />";
	};
	class TakeFlag: None
	{
		priority = 7;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\takeflag_ca.paa' size='1.8' shadow=2 />";
	};
	class ReturnFlag: None
	{
		priority = 8;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\returnflag_ca.paa' size='1.8' shadow=2 />";
	};
	class WeaponInHand: None
	{
		showWindow = 0;
		show = 0;
	};
	class WeaponOnBack: None
	{
		showWindow = 0;
		show = 0;
	};
	class SetTimer: None
	{
		priority = 2.1;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\settimer_ca.paa' size='1.8' shadow=2 />";
	};
	class TouchOff: None
	{
		priority = 0.1;
		showWindow = 1;
		show = 1;
	};
	class TouchOffMines: None
	{
		priority = 0.1;
		showWindow = 1;
		show = 1;
	};
	class Deactivate: None
	{
		priority = 2.1;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ico_OFF_ca.paa' size='1.8' shadow=2 />";
	};
	class FireInflame: None{};
	class FirePutDown: None{};
	class Salute: None
	{
		priority = 1;
		showWindow = 0;
		show = 0;
		shortcut = "Salute";
		text = "$STR_ACTION_SALUTE";
		textDefault = "$STR_ACTION_SALUTE";
	};
	class SitDown: None
	{
		priority = 1;
		showWindow = 0;
		show = 0;
		shortcut = "SitDown";
		text = "$STR_ACTION_SITDOWN";
		textDefault = "$STR_ACTION_SITDOWN";
	};
	class TakeMine: None
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_TAKE_MINE";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' size='1.8' shadow=2 />";
	};
	class DropWeapon: None
	{
		priority = 2;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_DROP_WEAPON";
	};
	class PutWeapon: DropWeapon
	{
		priority = 5;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_PUT_WEAPON";
	};
	class DeactivateMine: None
	{
		priority = 9.1;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ico_OFF_ca.paa' size='1.8' shadow=2 />";
	};
	class ActivateMine: None
	{
		priority = 9;
		showWindow = 1;
		show = 1;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ico_ON_ca.paa' size='1.8' shadow=2 />";
	};
	class UseContainerMagazine: None
	{
		priority = 9;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\ico_ON_ca.paa' size='1.8' shadow=2 />";
	};
	class UseMagazine: None
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		text = "%1";
		textDefault = "%1";
	};
	class CancelTakeFlag: None
	{
		priority = 8;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\close_ca.paa' size='1.8' shadow=2 />";
	};
	class CancelAction: None
	{
		showWindow = 0;
		show = 1;
		priority = 8;
		textDefault = "";
	};
	class MarkEntity: None{};
	class Assemble: None
	{
		priority = 6;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_ASSEMBLE";
		textDefault = "$STR_ACTION_ASSEMBLE";
	};
	class DisAssemble: None
	{
		priority = 5;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_DISASSEMBLE";
		textDefault = "$STR_ACTION_DISASSEMBLE";
	};
	class AIAssemble: None
	{
		priority = 6;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_ASSEMBLE";
		textDefault = "$STR_ACTION_ASSEMBLE";
	};
	class Talk: None
	{
		priority = 9;
		showWindow = 0;
		show = 0;
		text = "$STR_ACTION_ASK";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\talk_ca.paa' size='1.8' shadow=2 />";
	};
	class OpenParachute: None
	{
		priority = 9.1;
		showWindow = 1;
		show = 1;
		text = "$STR_A3_RSCGROUPROOTMENU_ITEMS_OPENPARACHUTE0";
	};
	class OpenParachuteSteerable: None
	{
		priority = 9.1;
		showWindow = 1;
		show = 1;
		text = "$STR_A3_CfgActions_OpenParachuteSteerable0";
	};
	class OpenParachuteNonSteerable: None
	{
		priority = 9.2;
		showWindow = 1;
		show = 1;
		text = "$STR_A3_CfgActions_OpenParachuteNonSteerable0";
	};
	class ActivateBreathingBomb: None
	{
		priority = 9.3;
		showWindow = 0;
		show = 1;
		text = "$STR_A3_CfgActions_ActivateBreathingBomb0";
	};
	class DeactivateBreathingBomb: None
	{
		priority = 9.4;
		showWindow = 0;
		show = 1;
		text = "$STR_A3_CfgActions_DeactivateBreathingBomb0";
	};
	class AutoHover: None
	{
		priority = 3;
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_HOVER";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\autohover_ca.paa' size='1.8' shadow=2 />";
	};
	class AutoHoverCancel: AutoHover
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\cancelhover_ca.paa' size='1.8' shadow=2 />";
	};
	class VTOLVectoring: AutoHover
	{
		priority = 3;
		showWindow = 0;
		show = 0;
		shortcut = "VTOLVectoringCancel";
		text = "$STR_VECTORING_OFF";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\VTOLVectoring_ca.paa' size='1.8' shadow=2 />";
	};
	class VTOLVectoringCancel: AutoHover
	{
		priority = 3;
		showWindow = 0;
		show = 1;
		shortcut = "VTOLVectoring";
		text = "$STR_VECTORING_ON";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\VTOLVectoringCancel_ca.paa' size='1.8' shadow=2 />";
	};
	class FlapsDown: None
	{
		priority = 0.7;
		showWindow = 0;
		show = 1;
		hideOnUse = 0;
		shortcut = "FlapsDown";
		text = "$STR_ACTION_FLAPS_DOWN";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\flapsExtend_ca.paa' size='1.8' shadow=2 />";
	};
	class FlapsUp: None
	{
		priority = 0.7;
		showWindow = 0;
		show = 1;
		hideOnUse = 0;
		shortcut = "FlapsUp";
		text = "$STR_ACTION_FLAPS_UP";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\flapsRetract_ca.paa' size='1.8' shadow=2 />";
	};
	class Land: None
	{
		priority = 0.9;
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_LAND";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\landingAutopilot_ON_ca.paa' size='1.8' shadow=2 />";
	};
	class CancelLand: None
	{
		priority = 0.9;
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_CANCEL_LAND";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\landingAutopilot_OFF_ca.paa' size='1.8' shadow=2 />";
	};
	class PeriscopeDepthOn: None
	{
		showWindow = 0;
		show = 1;
		text = "$STR_A3_LOC_PeriscopeDepthOn";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\periscopeDepth_ON_ca.paa' size='1.8' shadow=2 />";
	};
	class PeriscopeDepthOff: None
	{
		showWindow = 0;
		show = 1;
		text = "$STR_A3_LOC_PeriscopeDepthOff";
		textDefault = "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\periscopeDepth_OFF_ca.paa' size='1.8' shadow=2 />";
	};
	class PatchSoldier: None
	{
		priority = 10;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PatchSoldier0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\bandage_ca.paa' size='1.8' shadow=2 />";
	};
	class HealSoldierSelf: None
	{
		priority = 10;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_HealSoldierSelf0";
		textDefault = "<img image='\A3\ui_f\data\igui\cfg\actions\heal_ca.paa' size='1.8' shadow=2 />";
	};
	class PutInDriver: None
	{
		priority = 9.5;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PutInDriver0";
	};
	class PutInPilot: None
	{
		priority = 9.6;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PutInPilot0";
	};
	class PutInCargo: None
	{
		priority = 9.7;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PutInCargo0";
	};
	class PutInGunner: None
	{
		priority = 9.5;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PutInGunner0";
	};
	class PutInCommander: None
	{
		priority = 9.6;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PutInCommander0";
	};
	class PutInTurret: None
	{
		priority = 9.7;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_PutInTurret0";
	};
	class UnloadFromDriver: None
	{
		priority = 8.5;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadFromDriver0";
	};
	class UnloadFromPilot: None
	{
		priority = 8.6;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadFromPilot0";
	};
	class UnloadFromCargo: None
	{
		priority = 8.7;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadFromCargo0";
	};
	class UnloadFromCommander: None
	{
		priority = 8.5;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadFromCommander0";
	};
	class UnloadFromGunner: None
	{
		priority = 8.6;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadFromGunner0";
	};
	class UnloadFromTurret: None
	{
		priority = 8.7;
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_UnloadFromTurret0";
	};
	class HealBleedingOnly: None
	{
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_HealBleedingOnly0";
	};
	class HealBleedingSelfOnly: None
	{
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_HealBleedingSelfOnly0";
	};
	class HealSoldierAuto: None
	{
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_HealSoldierAuto0";
	};
	class HealBleedingAuto: None
	{
		showWindow = 0;
		show = 0;
		text = "$STR_A3_CfgActions_HealBleedingAuto0";
	};
	class ActivateFins: None
	{
		showWindow = 1;
		show = 1;
		text = "$STR_A3_CfgActions_ActivateFins0";
	};
	class DeactivateFins: None
	{
		showWindow = 1;
		show = 1;
		text = "$STR_A3_CfgActions_DeactivateFins0";
	};
	class LightOn: None
	{
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_LIGHTS_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_land_ON_ca' size='2' shadow='true' />";
		modelPositions = "switch_lightsldg";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
	};
	class LightOff: LightOn
	{
		text = "$STR_ACTION_LIGHTS_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_land_OFF_ca' size='2' shadow='true' />";
	};
	class CollisionLightOn: None
	{
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_COLLISIONLIGHTS_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_col_ON_ca' size='2' shadow='true' />";
		modelPositions = "switch_lightsac";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
	};
	class CollisionLightOff: CollisionLightOn
	{
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_COLLISIONLIGHTS_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_col_OFF_ca' size='2' shadow='true' />";
	};
	class BatteriesOn: None
	{
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_BATTERIES_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_batt_ON_ca' size='2' shadow='true' />";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		modelPositions = "switch_batteries";
	};
	class BatteriesOff: BatteriesOn
	{
		priority = 2;
		text = "$STR_ACTION_BATTERIES_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_batt_OFF_ca' size='2' shadow='true' />";
	};
	class APUOn: None
	{
		priority = 4;
		showWindow = 1;
		show = 1;
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		modelPositions = "switch_apu";
		text = "$STR_ACTION_APU_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_ON_ca' size='2' shadow='true' />";
	};
	class APUOff: APUOn
	{
		priority = 3;
		text = "$STR_ACTION_APU_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_OFF_ca' size='2' shadow='true' />";
	};
	class StarterOn1: None
	{
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_STARTER1_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_start_ON_ca' size='2.5' shadow='true' />";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_starter","switch_starter_2"};
	};
	class StarterOff1: StarterOn1
	{
		priority = 3;
		text = "$STR_ACTION_STARTER1_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_start_OFF_ca' size='2.5' shadow='true' />";
	};
	class StarterOn2: None
	{
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_STARTER2_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_start_ON_ca' size='2.5' shadow='true' />";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_starter2","switch_starter2_2"};
	};
	class StarterOff2: StarterOn2
	{
		priority = 3;
		text = "$STR_ACTION_STARTER2_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_start_OFF_ca' size='2.5' shadow='true' />";
	};
	class StarterOn3: None
	{
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_STARTER3_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_start_ON_ca' size='2.5' shadow='true' />";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_starter3","switch_starter3_2"};
	};
	class StarterOff3: StarterOn3
	{
		priority = 3;
		text = "$STR_ACTION_STARTER3_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_start_OFF_ca' size='2.5' shadow='true' />";
	};
	class ThrottleOff1: None
	{
		priority = 3;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_THROTTLE1_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_OFF_ca' size='2' shadow='true' />";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_throttle","switch_throttle_2"};
	};
	class ThrottleIdle1: ThrottleOff1
	{
		priority = 3;
		text = "$STR_ACTION_THROTTLE1_IDLE";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_IDL_ca' size='2' shadow='true' />";
	};
	class ThrottleFull1: ThrottleOff1
	{
		priority = 3;
		text = "$STR_ACTION_THROTTLE1_FULL";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_ON_ca' size='2' shadow='true' />";
	};
	class ThrottleOff2: None
	{
		priority = 3;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_THROTTLE2_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_OFF_ca' size='2' shadow='true' />";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_throttle2","switch_throttle2_2"};
	};
	class ThrottleIdle2: ThrottleOff2
	{
		priority = 3;
		text = "$STR_ACTION_THROTTLE2_IDLE";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_IDL_ca' size='2' shadow='true' />";
	};
	class ThrottleFull2: ThrottleOff2
	{
		priority = 3;
		text = "$STR_ACTION_THROTTLE2_FULL";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_ON_ca' size='2' shadow='true' />";
	};
	class ThrottleOff3: None
	{
		priority = 3;
		showWindow = 1;
		show = 1;
		text = "$STR_ACTION_THROTTLE3_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_OFF_ca' size='2' shadow='true' />";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_throttle3","switch_throttle3_2"};
	};
	class ThrottleIdle3: ThrottleOff3
	{
		priority = 4;
		text = "$STR_ACTION_THROTTLE3_IDLE";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_IDL_ca' size='2' shadow='true' />";
	};
	class ThrottleFull3: ThrottleOff3
	{
		priority = 4;
		text = "$STR_ACTION_THROTTLE3_FULL";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_ON_ca' size='2' shadow='true' />";
	};
	class RotorBrakeOn: None
	{
		priority = 0.6;
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_ROTOR_BRAKE_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_cpt_brk_ON_ca' size='2' shadow='true' />";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		modelPositions = "switch_rotor_brake";
	};
	class RotorBrakeOff: RotorBrakeOn
	{
		priority = 0.3;
		text = "$STR_ACTION_ROTOR_BRAKE_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_OFF_ca' size='2' shadow='true' />";
	};
	class WheelsBrakeOn: None
	{
		priority = 0.6;
		showWindow = 0;
		show = 1;
		text = "$STR_ACTION_BRAKE_ON";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_ON_ca' size='2' shadow='true' />";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 0;
		modelPositions = "switch_rotor_brake";
	};
	class WheelsBrakeOff: WheelsBrakeOn
	{
		priority = 0.3;
		text = "$STR_ACTION_BRAKE_OFF";
		textDefault = "<img image='A3\ui_f\data\igui\cfg\actions\ico_OFF_ca' size='2' shadow='true' />";
	};
};

