/*
    File: player_gear_set.sqf
    Author: Dscha
    Date: 2020-11-04
    Last Update: 2020-12-09
    Public: No
    
    Description:
        Sets the player Inventory ItemData

		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset_raw =	TODO
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/

private _DEBUGON = false;

diag_log "DEBUG: PLAYER GEAR SET: ... Start";

params["_dataset_raw"];
_dataset = createHashMap;
_dataset insert _dataset_raw;

private _inventories_raw = _dataset get "inventory";
private _itemDataPlayer_raw = _dataset get "itemData";

if(_DEBUGON)then{diag_log format["DEBUG: PLAYER GEAR SET: RAW Keys        : %1", keys _dataset];};
if(_DEBUGON)then{diag_log format["DEBUG: PLAYER GEAR SET: RAW Inventories : %1", _inventories_raw];};
if(_DEBUGON)then{diag_log format["DEBUG: PLAYER GEAR SET: RAW Items       : %1", _itemDataPlayer_raw];};

// save the Inventory and Slots, as properly defined hashmaps
diag_log "DEBUG: PLAYER GEAR SET: Setting Inventory data...";
_inventoryData = createHashMap;
{
	_x params ["_invSubID","_invSubData"];
	private _data = createHashMap;
	_data insert _invSubData;
	_inventoryData set [_invSubID, _data];
}forEach _inventories_raw;
diag_log "DEBUG: PLAYER GEAR SET: Setting Inventory data... Done";

// Item data for each Item in the Inventory
diag_log "DEBUG: PLAYER GEAR SET: Setting Inventory Items...";
private _itemDataPlayer = createHashMap;
_start = diag_tickTime;
{
	if(_DEBUGON)then{diag_log format["DEBUG: PLAYER GEAR SET: Item Data       : %1", _x];};
	_x params["_item_id", "_itemData_raw"];
	private _itemData = createHashMap;
	_itemData insert _itemData_raw;	// convert all the subentries to a hashmap ([key,value])
	_itemDataPlayer set [_item_id, _itemData];
}forEach _itemDataPlayer_raw;
_end = diag_tickTime;
diag_log "DEBUG: PLAYER GEAR SET: Setting Inventory Items... Done";
if(_DEBUGON)then{diag_log format["DEBUG: PLAYER GEAR SET: Items           : %1", count _itemDataPlayer_raw];};
if(_DEBUGON)then{diag_log format["DEBUG: PLAYER GEAR SET: Time            : %1 ms", _end - _start];};



diag_log "DEBUG: PLAYER GEAR SET: Setting Inventory MainData...";
AN_data_inventory = createHashMap;
AN_data_inventory insert
[
	 ["crateID", getPlayerUID player]		// Local == Always PUID!
	,["inventory",_inventoryData]			// 
	,["itemData", _itemDataPlayer ]
];
diag_log "DEBUG: PLAYER GEAR SET: Setting Inventory MainData... Done";
diag_log "DEBUG: PLAYER GEAR SET: ... Done";
diag_log "------------------";


