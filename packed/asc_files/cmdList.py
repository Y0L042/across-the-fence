from test_commands import *
from asc_fnc import *
from anarchy_main.client import *
from anarchy_main.inventory import *
from anarchy_main.factions import *

# Format:
# "tag" : filename.function

cmdList = {
		'server': {
				# Server:
				# # Add users to the await list (player has connected and waits for the Backend connection)
				"user_add": asc_s_lst_client.client_await_add,
				# # Player disconnected
				"user_rem": asc_s_lst_client.client_active_rem,

				# Factions:
				# # update data
				"fac_stats_upd": factions_handler.faction_stats_update,

				# Inventory:
				# # Try to get data from crates/Inventories.
				"crate_data_get": inv_handler.crate_data_get,
				# # remove crates from the database
				"crate_rem": inv_handler.crate_rem,

				# Item Handling:
				# # Degradation (WIP)
				"player_fired": item_handler.item_degrade,

				# Player:
				# # update stats
				"update_players": client_handler.players_stats_update,
				# # Update the faction? Might be, idk
				"player_update_faction": client_handler.player_update_faction
			},
		'arma_server': {
				# "functionTag in Arma": "Function to execute"
				# NOTE: Make sure, that the Tag is compatible with the Arma 3 Variable logic
				#
				"s_example_return":         {"fnc": "ASC_fnc_example", "spawn": 0},
				"s_test":                   {"fnc": "ASC_fnc_example", "spawn": 0},
				"s_abc":                    {"fnc": "ASC_fnc_example", "spawn": 0},

				# Factions:
				# set factions data
				"fac_data_load":             {"fnc": "AN_S_fnc_factions_data_load", "spawn": 0},

				# Players:
				# player spawning
				"loadout_set":            {"fnc": "AN_S_fnc_loadout_set", "spawn": 1},

				# Inventory
				"crate_add":                {"fnc": "AN_S_fnc_crate_add", "spawn": 0}
			},
		'client': {
				# ""Tag" send from Arma" : Function in the backend
				# NOTE: Make sure, that you imported the related plugin/method/folder/however it's called (and added the files to the "__init.py__" )
				"itemMove":         item_handler.item_move,
				"inv_get_grid":     inv_handler.inv_grid_get,
				"inv_get_items":    inv_handler.inv_items_get
			},
		'arma_client': {
				# "functionTag in Arma": "Function to execute"
				# NOTE: Make sure, that the Tag is compatible with the Arma 3 Variable logic
				"INIT_CLIENTDATA":      {"fnc": "an_c_fnc_clientData_init", "spawn": 0},
				"INIT_ITEMDATA":        {"fnc": "an_c_fnc_ui_inv_item_data_init", "spawn": 0},
				"ret_inv_get_grid":     {"fnc": "DEV_an_fnc_hintGrid", "spawn": 0},
				"ret_inv_get_items":    {"fnc": "DEV_an_fnc_hintItemData", "spawn": 0},
				"ret_inv_crateData":    {"fnc": "AN_c_fnc_loot_inv_get", "spawn": 0}
			}
		}
