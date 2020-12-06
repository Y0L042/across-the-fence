from asc_fnc import *
from anarchy_main.inventory import *
from asc_fnc.asc_db import database
from printHandler import *

def client_add(**kwargs):
	# Default Values for new Clients
	cData = {
		'puid': "-1",
		'skills': {
				'scavenging': 0
			},
		# 'health':   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],     # currently disabled, A3 issues (updating on/from/to Server...)
		'health': 0,
		'stats':    {
				"hunger": 100,
				"thirst": 100
			},
		'pos':      [
				[0, 0, 0],
				0,
				""
			],
		"faction": "CIV",   # Standard start faction
		'inv_usedSlots': [],
		'inventory': {
			"0": {
				"inv_grid": inv_handler.inv_grid_create(20, 8),  # DEV VALUES
				"inv_rows": 20,  # DEV VALUES
				'inv_cols': 8  # DEV VALUES
				},
			# Uniform
			"12": {
				"inv_grid": inv_handler.inv_grid_create(16, 8),  # DEV VALUES
				"inv_rows": 16,  # DEV VALUES
				'inv_cols': 8  # DEV VALUES
				},
			# Vest
			"13": {
				"inv_grid": inv_handler.inv_grid_create(4, 8),  # DEV VALUES
				"inv_rows": 4,  # DEV VALUES
				'inv_cols': 8  # DEV VALUES
				},
			# Pouch
			"14": {
				"inv_grid": inv_handler.inv_grid_create(4, 8),  # DEV VALUES
				"inv_rows": 4,  # DEV VALUES
				'inv_cols': 8  # DEV VALUES
				},
			# Backpack
			"15": {
				"inv_grid": inv_handler.inv_grid_create(4, 8),  # DEV VALUES
				"inv_rows": 4,  # DEV VALUES
				'inv_cols': 8  # DEV VALUES
				}
			},
		'itemData': {}
		}

	cData.update(kwargs)

	# PRINT_DEBUG(item)
	return cData

# Note: called from asc_client
def client_init(self):
	self.cData = player_data_get(self.sData, self.puid)
	if len(self.cData) == 0:
		PRINT_ATTENTION(f"ASC: CLIENT HANDLER: PUID NOT FOUND. CREATING NEW ENTRY FOR PUID: {self.puid}")
		self.cData = client_add(puid=self.puid)
		player_data_set(self.sData, self.puid, self.cData)

		# add Starter Gear:
		startGear = [["vn_b_uniform_macv_01_06", [12]], ["vn_b_bandana_03", [10]]]
		for itemData in startGear:
			item = inv_handler.inv_item_create(parent=itemData[0], slot=itemData[1], doSlot=True)
			item["curInv"] = self.cData["puid"]
			# Add it to the itemData (inventory) - Since those Items are already "equipped", they won't take any slots.
			self.cData["itemData"][item["id"]] = item

	# filter out all the equipped Gear and send it as a "special" set to the Server, so the Client can be equipped
	listGear = []
	for x in self.cData["itemData"]:
		# noinspection PyTypeChecker
		slotID = self.cData["itemData"][x]["inSlot"]
		if slotID > 0:
			listGear.append(self.cData["itemData"][x])

	# Server:
	# send Player Dataset over to the Server, so it can set up the player:
	PRINT_DEBUG(f"SENDING: DATASET FROM {self.puid} TO GAMESERVER...")

	# submit: faction
	dataset = {
		"data_puid": self.puid,
		"data_faction": self.cData["faction"]
		}
	asc_g_msg.sendMsg("player_faction_set", dataset, self.sData.con_gameServer)

	# submit: loadout
	dataset = {
		"data_puid": self.puid,
		"data_gear": listGear
		}
	asc_g_msg.sendMsg("player_loadout_set", dataset, self.sData.con_gameServer)

	# submit: pos/dir/stance
	dataset = {
		"data_puid": self.puid,
		"data_pos": self.cData["pos"]
		}
	asc_g_msg.sendMsg("player_pos_set", dataset, self.sData.con_gameServer)

	# submit: health
	dataset = {
		"data_puid": self.puid,
		"data_health": self.cData["health"]
		}
	asc_g_msg.sendMsg("player_health_set", dataset, self.sData.con_gameServer)

	PRINT_OK(f"SENDING: DATASET FROM {self.puid} TO GAMESERVER... Done")
	# All Data was send to the Server.
	#################################
	# Now send the data to the client:

	# send itemParent Definitions
	PRINT_DEBUG(f"SENDING: INIT_ITEMDATA TO {self.puid}... ")
	asc_g_msg.sendMsg("INIT_ITEMDATA", self.sData.itemParentData, self.con_client)
	PRINT_OK(f"SENDING: INIT_ITEMDATA TO {self.puid}... DONE")

	# Gear:
	PRINT_DEBUG(f"SENDING: INVENTORY ITEMDATA TO {self.puid}...")
	dataset = {
			"itemData": self.cData["itemData"],
			# "inventory": self.cData["inventory"]
			"inv_rows": self.cData["inventory"]["12"]["inv_rows"],  # ToDo: Send all grids (12-15) - Needs .sqf adjustments first!
			"inv_cols": self.cData["inventory"]["12"]["inv_cols"]   # ToDo: Send all grids (12-15) - Needs .sqf adjustments first!
		}
	# remove the grid from the data, passed to the client.
	asc_g_msg.sendMsg("player_gear_set", dataset, self.con_client)
	PRINT_OK(f"SENDING: INVENTORY ITEMDATA TO {self.puid}... DONE")

	# Skills
	PRINT_DEBUG(f"SENDING: SKILLS TO {self.puid}...")
	dataset = {
		"skills": self.cData["skills"]
		}
	asc_g_msg.sendMsg("player_skills_set", dataset, self.con_client)
	PRINT_OK(f"SENDING: SKILLS TO {self.puid}... DONE")

	# send the "Client has passed the ASC init phase" message to the Server
	PRINT_OK(f'PLAYER INIT DONE FOR {self.puid} - SENDING "PLAYER READY" TO THE GAMESERVER')
	asc_g_msg.sendMsg("INIT_PLAYER_DONE", {"data_puid": self.puid}, self.con_server)



def player_data_get(sData, puid):
	# PRINT_DEBUG("player_data_get: puid:", puid)
	# PRINT_DEBUG(sData.database.players)
	try:
		pData = sData.database.players[puid]
	except KeyError:
		pData = {}
	return pData

def player_data_set(sData, puid, data):
	try:
		sData.database.players[puid] = data
		database.asc_db.db_save(sData.database)
	except KeyError:
		# PRINT_WARNING(f"ASC_DB: PlayerUID [{puid}] not found!")
		pass


def players_stats_update(sData, *datalist):
	# PRINT_DEBUG(f"datalist - {datalist}")
	for data in datalist:
		try:
			# PRINT_DEBUG(f"data - {data}")
			puid, data_stats = data
			pData = player_data_get(sData, puid)
			for stat in data_stats:
				# PRINT_DEBUG(f"stat - {stat}")
				stat_type, stat_value = stat
				pData[stat_type] = stat_value
		except Exception as e:
			PRINT_WARNING(f"ERROR: players_stat_update: ERROR: {e}")

	database.asc_db.db_save(sData.database)


def player_update_faction(sData, *data):
	puid, faction = data
	pData = player_data_get(sData, puid)
	PRINT_ATTENTION(f"DEBUG: player_update_faction: {puid} joined faction {faction} (previous: {pData['faction']})")
	pData["faction"] = faction
	# save to file
	database.asc_db.db_save(sData.database)


def player_killed(sData, *data):
	puid, dropCrateID = data
	# move all Items from the Client to the newly created "dropCrate"
	cData = player_data_get(sData, puid)
	client = sData.userlist[puid]
	crateData = sData.database.sessionCrates[dropCrateID]

	# avoid runtime Error (due to dict changing, during the for loop)
	items_cData = list(cData["itemData"])
	for itemID in items_cData:

		itemData = cData["itemData"][itemID]

		# "move" the Items to the newly created Crate
		# ToDo: Recheck again later, if "inv_item_move" must be used here (rel: ItemStats)
		invData, item = inv_handler.inv_item_add_to_inv(sData, invData=crateData, isLootcrate=1, item=itemData)

		# remove the old Item cData
		cData["itemData"].pop(itemID)

		# Reset the Item back to an Inventory Slot, inside a crate
		item["inSlot"] = 0
		item["invSub"] = "0"

	# reset the grid of the player to the Standard Value:
	cData["inventory"]["12"]["inv_grid"] = inv_handler.inv_grid_create(16, 8)   # TODO: DEV VALUE - Needs .sqf adjustments first!
	cData["inventory"]["13"]["inv_grid"] = inv_handler.inv_grid_create(4, 8)    # TODO: DEV VALUE - Needs .sqf adjustments first!
	cData["inventory"]["14"]["inv_grid"] = inv_handler.inv_grid_create(4, 8)    # TODO: DEV VALUE - Needs .sqf adjustments first!
	cData["inventory"]["15"]["inv_grid"] = inv_handler.inv_grid_create(4, 8)    # TODO: DEV VALUE - Needs .sqf adjustments first!

	# add Starter Gear:
	startGear = [["vn_b_uniform_macv_01_06", [12]], ["vn_b_bandana_03", [10]]]
	for itemData in startGear:
		item = inv_handler.inv_item_create(parent=itemData[0], slot=itemData[1], doSlot=True)
		item["curInv"] = cData["puid"]
		# Add it to the itemData (inventory) - Since those Items are already "equipped", they won't take any slots.
		cData["itemData"][item["id"]] = item

	# force-update the player Inventory, so all the values will be reset
	# Does NOT trigger the reopening of the Inventory, since player is dead!
	inv_handler.inv_data_update_force(client, dropCrateID, puid)

	# save to file
	# ToDo: finally add some proper "DB-saver"
	database.asc_db.db_save(sData.database)


def player_respawned(sData, puid):
	PRINT_ATTENTION(f"DEBUG: PLAYER_RESPAWNED: puid: {puid}")
	cData = player_data_get(sData, puid)
	listGear = []
	for x in cData["itemData"]:
		# noinspection PyTypeChecker
		slotID = cData["itemData"][x]["inSlot"]
		if slotID > 0:
			listGear.append(cData["itemData"][x])
	# submit: loadout
	dataset = {
		"data_puid": puid,
		"data_gear": listGear
		}
	asc_g_msg.sendMsg("player_loadout_set", dataset, sData.con_gameServer)
