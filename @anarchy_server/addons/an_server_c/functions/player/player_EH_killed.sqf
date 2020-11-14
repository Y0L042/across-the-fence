


params ["_unit", "_killer", "_instigator", "_useEffects"];

if(alive _unit)exitWith{};

private _pos = getPosATL _unit;
[_unit, _pos] call an_s_fnc_loot_last_pos_set;
// ToDo: Check if _unit in Vehicle, in the Air, on Water... oh god... -.-
private _dropCrate = [_unit] call AN_S_fnc_loot_items_dropped;
_created = [_dropCrate, 0, _unit] call AN_s_fnc_loot_request_crate_inventory;

if(_created)then
{
	// move the player Inventory to the newly created "dropCrate"
	
};