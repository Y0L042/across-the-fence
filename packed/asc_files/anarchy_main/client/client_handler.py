from asc_fnc import *
from anarchy_main.inventory import *
from asc_fnc.asc_db import database


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
		'inv_grid': inv_handler.invGrid_create(16),
		'itemData': {},
		'ammo': {
				"ammoType_a": 0,
				"ammoType_b": 0,
				"ammoType_c": 0,
				"ammoType_d": 0
			}
		}

	cData.update(kwargs)

	# print(item)
	return cData

# Note: called from asc_client
def client_init(self):
	self.cData = player_data_get(self.sData, self.puid)
	if len(self.cData) == 0:
		print(f"ASC: CLIENT HANDLER: PUID NOT FOUND. CREATING NEW ENTRY FOR PUID: {self.puid}")
		self.cData = client_add(puid=self.puid)
		player_data_set(self.sData, self.puid, self.cData)

		# add Starter Gear:
		startGear = [["vn_b_bandana_03", 10], ["vn_b_uniform_macv_01_06", 12]]
		for itemData in startGear:
			item = item_handler.item_create(parent=itemData[0], slot=itemData[1], doSlot=True)
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
	print(f"SENDING: DATASET FROM {self.puid} TO GAMESERVER...")

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

	print(f"SENDING: DATASET FROM {self.puid} TO GAMESERVER... Done")
	# All Data was send to the Server.
	#################################
	# Now send the data to the client:

	# send itemParent Definitions
	print(f"SENDING: INIT_ITEMDATA TO {self.puid}... ")
	asc_g_msg.sendMsg("INIT_ITEMDATA", self.sData.itemParentData, self.con_client)
	print(f"SENDING: INIT_ITEMDATA TO {self.puid}... DONE")

	# send player Data
	print(f"SENDING: INIT_CLIENTDATA TO {self.puid}...")
	# asc_g_msg.sendMsg("INIT_CLIENTDATA", self.cData, self.con_client)

	# Gear:
	print(f"SENDING: INVENTORY ITEMDATA TO {self.puid}...")
	dataset = {
			"itemData": self.cData["itemData"],
			"inv_grid": self.cData["inv_grid"]
		}
	# remove the grid from the data, passed to the client.
	asc_g_msg.sendMsg("player_gear_set", dataset, self.con_client)
	print(f"SENDING: INVENTORY ITEMDATA TO {self.puid}... DONE")

	# Skills
	print(f"SENDING: SKILLS TO {self.puid}...")
	dataset = {
		"skills": self.cData["skills"]
		}
	asc_g_msg.sendMsg("player_skills_set", dataset, self.con_client)
	print(f"SENDING: SKILLS TO {self.puid}... DONE")

	# send the "Client has passed the ASC init phase" message to the Server
	print(f'PLAYER INIT DONE FOR {self.puid} - SENDING "PLAYER READY" TO THE GAMESERVER')
	asc_g_msg.sendMsg("INIT_PLAYER_DONE", {"data_puid": self.puid}, self.con_server)



def player_data_get(sData, puid):
	# print("player_data_get: puid:", puid)
	# print(sData.database.players)
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
		# print(f"ASC_DB: PlayerUID [{puid}] not found!")
		pass


def players_stats_update(sData, *datalist):
	# print(f"datalist - {datalist}")
	for data in datalist:
		try:
			# print(f"data - {data}")
			puid, data_stats = data
			pData = player_data_get(sData, puid)
			for stat in data_stats:
				# print(f"stat - {stat}")
				stat_type, stat_value = stat
				pData[stat_type] = stat_value
		except Exception as e:
			print(f"ERROR: players_stat_update: ERROR: {e}")

	database.asc_db.db_save(sData.database)


def player_update_faction(sData, *data):
	puid, faction = data
	pData = player_data_get(sData, puid)
	print(f"DEBUG: player_update_faction: {puid} joined faction {faction} (previous: {pData['faction']})")
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
		# ToDo: Recheck again later, if "item_move" must be used here (rel: ItemStats)
		invData, item = item_handler.item_add_to_inv(sData, invData=crateData, isLootcrate=1, item=itemData)

		# remove the old Item cData
		cData["itemData"].pop(itemID)

		# Reset the Item back to an Inventory Slot
		item["inSlot"] = 0

	# reset the grid of the player to the Standard Value:
	cData["inv_grid"] = inv_handler.invGrid_create(16)

	# add Starter Gear:
	startGear = [["vn_b_bandana_03", 10], ["vn_b_uniform_macv_01_06", 12]]
	for itemData in startGear:
		item = item_handler.item_create(parent=itemData[0], slot=itemData[1], doSlot=True)
		item["curInv"] = cData["puid"]
		# Add it to the itemData (inventory) - Since those Items are already "equipped", they won't take any slots.
		cData["itemData"][item["id"]] = item

	# force-update the player Inventory, so all the values will be reset
	# Does NOT trigger the reopening of the Inventory, since player is dead!
	inv_handler.inv_update_force(client, dropCrateID, puid)


	# save to file
	# ToDo: finally add some proper "DB-saver"
	database.asc_db.db_save(sData.database)

