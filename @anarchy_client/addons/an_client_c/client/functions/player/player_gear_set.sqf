/*
    File: player_gear_set.sqf
    Author: Dscha
    Date: 2020-11-04
    Last Update: 2020-11-04
    Public: No
    
    Description:
        Sets the player Inventory ItemData

		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset =	[
						"itemData",
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

//Item data for each Item in the Inventory
private _itemDataPlayer = ENTRY_GET("itemData", _dataset);
diag_log format["ASC: Inventory _itemDataPlayer	: %1", _itemDataPlayer];
{
	_x params["_item_id", "_itemData"];
	
	diag_log format["ASC: INV Entry	: %1", _x];
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
			["crateID", getPlayerUID player],
			["inventory", ENTRY_GET("inventory", _dataset)],
			["itemData", _itemDataPlayer ]
		]
	];
diag_log "------------------";