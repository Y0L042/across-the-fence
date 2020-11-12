/*
	Called when closing the Inventory.
	Checks if a player opened his Inventory and wants to drop Items on the Ground, without having any Loot- or droppedCrate selected.
	Triggers the creation of the droppedCrate on the Server.
*/

private _gridExt = uinamespace getvariable ["an_inv_external_grid",controlNull];
private _gridUsedSlots = [(ctrlIDC _gridExt)] call an_c_fnc_ui_inv_grid_tiles_used_get;

if(player getVariable["an_inv_dropActive",false])then
{
	if !(_gridUsedSlots isEqualTo []) then
	{
		[ "loot_items_dropped", [] ] call para_c_fnc_call_on_server;
	};
};