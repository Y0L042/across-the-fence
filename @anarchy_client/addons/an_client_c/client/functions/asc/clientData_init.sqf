#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"

/*

	WIP (in case it isn't obvious)

	usage:
	Set up the player data and start all the loops from here.

*/

params["_data"];

diag_log ":::::::::::::::::::: CLIENT DATA INIT ::::::::::::::::::::";
// diag_log str _this;
diag_log "------------------";


//Health
an_cData_health = ENTRY_GET("health", _data);
diag_log format["CLD_INIT: Health FULL	: %1", an_cData_health];
/*
// NOTE: getHitPointDamage issue (not updating on the Server)
{
	diag_log format["CLD_INIT: Entry		: %1", _x];
}forEach an_cData_health;
*/
diag_log "------------------";


//Item data for each Item in the Inventory
_itemDataPlayer = ENTRY_GET("itemData", _data);
diag_log format["CLD_INIT: Item Data	: %1", _itemDataPlayer];
{
	_x params["_item_id", "_itemData"];
	
	diag_log format["CLD_INIT: INV Entry	: %1", _x];
	// Store the ItemData
	localNamespace setVariable [_item_id, _itemData];
	private _inSlot = ENTRY_GET("inSlot", _itemData);
	if(_inSlot != 0)then
	{
		_addToSlot = [_inSlot, _itemData] call an_c_fnc_ui_inv_item_slotted_add;
		if(!_addToSlot)then
		{
			diag_log format["ERROR: CLD_INIT: ITEM NOT ADDED TO SLOT! : Slot: %1 - ItemData: %2", _inSlot, _itemData];
		};
	};
	// diag_log ["DEBUG: LNS DATA: ", localNamespace getVariable [_item_id,"NONE"]];
}forEach _itemDataPlayer;

// save the current Inventory, properly defined, so it can be used with "ui_inv_load".
localNamespace setVariable ["an_cData_invData",
		[
			["crateID",getPlayerUID player],
			["inv_rows", count(ENTRY_GET("inv_grid", _data))],
			["itemData", _itemDataPlayer ]
		]
	];
diag_log "------------------";


// Current Position + Direction
an_cData_pos = ENTRY_GET("pos", _data);
diag_log format["CLD_INIT: Pos			: %1", an_cData_pos];
diag_log "------------------";


//Skillpoints
an_cData_skills = ENTRY_GET("skills", _data);
diag_log format["CLD_INIT: Skills FULL	: %1", an_cData_skills];
{
	diag_log format["CLD_INIT: Entry		: %1", _x];
}forEach an_cData_skills;
diag_log "------------------";


// Spawn and start the Loot-bubble-thingy-function-stuff
vn_an_crates = [];
[] spawn
{
	systemChat "DEBUG: Starting loot bubble check";
	// make loot spawn
	while {true} do
	{
		call AN_C_fnc_loot_bubble;
		uiSleep 0.02;
	};
};