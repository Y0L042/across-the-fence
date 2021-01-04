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
			# External Grid - Default Values - needed!
			"1000": {
				"crateID": "-1",
				"inv_rows": 1,
				'inv_cols': 8,
				"invID":    "1000",
				"invArea":  "an_inv_external_area",
				"invGrid":  "an_inv_external_grid",
				"slotsUsed": [],
				"isSlot": 0
				},
			# Inventory - Uniform
			"1012": {
				"crateID": "-1",
				"inv_rows": 8,
				"inv_cols": 8,
				"invID": "1012",
				"invArea": "an_inv_uni_area",
				"invGrid": "an_inv_uni_grid",
				"slotsUsed": [],
				"isSlot": 0
				},
			# Inventory - Vest
			"1013": {
				"crateID": "-1",
				"inv_rows": 0,
				"inv_cols": 8,
				"invID": "1013",
				"invArea": "an_inv_vst_area",
				"invGrid": "an_inv_vst_grid",
				"slotsUsed": [],
				"isSlot": 0
				},
			# Inventory - Pouch
			"1014": {
				"crateID": "-1",
				"inv_rows": 0,
				"inv_cols": 8,
				"invID": "1014",
				"invArea": "an_inv_pch_area",
				"invGrid": "an_inv_pch_grid",
				"slotsUsed": [],
				"isSlot": 0
				},
			# Inventory - Backpack
			"1015": {
				"crateID": "-1",
				"inv_rows": 0,
				"inv_cols": 8,
				"invID": "1015",
				"invArea": "an_inv_bkp_area",
				"invGrid": "an_inv_bkp_grid",
				"slotsUsed": [],
				"isSlot": 0
				},

			# Slots:
			# Slot - Weapon - Main
			"2002": {
				"crateID": "-1",
				"inv_rows": 4,
				"inv_cols": 6,
				"invID": "2002",
				"invArea": "an_slot_wpn_area",
				"invGrid": "an_slot_wpn_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Weapon - Main (second slot)
			"2202": {
				"crateID": "-1",
				"inv_rows": 4,
				"inv_cols": 6,
				"invID": "2202",
				"invArea": "an_slot_wpn_b_area",
				"invGrid": "an_slot_wpn_b_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Weapon - secondary
			"2003": {
				"crateID": "-1",
				"inv_rows": 2,
				"inv_cols": 4,
				"invID": "2003",
				"invArea": "an_slot_sec_area",
				"invGrid": "an_slot_sec_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Weapon - Launcher
			"2004": {
				"crateID": "-1",
				"inv_rows": 4,
				"inv_cols": 6,
				"invID": "2004",
				"invArea": "an_slot_lau_area",
				"invGrid": "an_slot_lau_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Helmet
			"2010": {
				"crateID": "-1",
				"inv_rows": 3,
				"inv_cols": 3,
				"invID": "2010",
				"invArea": "an_slot_hel_area",
				"invGrid": "an_slot_hel_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Goggles
			"2011": {
				"crateID": "-1",
				"inv_rows": 2,
				"inv_cols": 2,
				"invID": "2011",
				"invArea": "an_slot_gog_area",
				"invGrid": "an_slot_gog_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Uniform
			"2012": {
				"crateID": "-1",
				"inv_rows": 6,
				"inv_cols": 4,
				"invID": "2012",
				"invArea": "an_slot_uni_area",
				"invGrid": "an_slot_uni_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Vest
			"2013": {
				"crateID": "-1",
				"inv_rows": 4,
				"inv_cols": 4,
				"invID": "2013",
				"invArea": "an_slot_vst_area",
				"invGrid": "an_slot_vst_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Backpack
			"2015": {
				"crateID": "-1",
				"inv_rows": 4,
				"inv_cols": 4,
				"invID": "2015",
				"invArea": "an_slot_bkp_area",
				"invGrid": "an_slot_bkp_grid",
				"slotsUsed": [],
				"isSlot": 1
				},
			# Slot - Bino
			"2017": {
				"crateID": "-1",
				"inv_rows": 3,
				"inv_cols": 3,
				"invID": "2017",
				"invArea": "an_slot_bin_area",
				"invGrid": "an_slot_bin_grid",
				"slotsUsed": [],
				"isSlot": 1
				}
			# ToDo: Slot - Pouch
			# ToDo: Slot - Tool
			},
		'itemData': {}
		}

	cData.update(kwargs)

	# PRINT_DEBUG(item)
	return cData

# Note: called from asc_client
def client_init(self):
	self.cData = player_data_get(self.sData, self.puid)
	if not self.cData:
		PRINT_ATTENTION(f"ASC: CLIENT HANDLER: PUID NOT FOUND. CREATING NEW ENTRY FOR PUID: {self.puid}")
		self.cData = client_add(puid=self.puid)
		player_data_set(self.sData, self.puid, self.cData)

		# add Starter Gear:
		startGear = [
				"vn_b_uniform_macv_01_06",
				"vn_b_vest_aircrew_01",
				"vn_b_pack_02",
				"vn_b_bandana_03",
				"vn_b_aviator",
				"vn_m19_binocs_grey",
				"vn_m14_BetterCondition",
				"vn_hp",
				"launch_RPG32_F"
			]
		for itemName in startGear:
			item = inv_handler.item_create(sData=self.sData, itemSubTypeName=itemName)
			parentData = inv_handler.item_baseData_get(sData=self.sData, subTypeName=item["subType"])
			# "slot" can have multiple entries, first entry is always the "main equip-slot"!
			slot = parentData["baseData"]["slot"][0]
			inv_handler.inv_item_new_add(sData=self.sData, invData=self.cData, item=item, invSubID=slot, crateID=self.puid)
	# update the mainID:
	for subInv in self.cData["inventory"]:
		self.cData["inventory"][subInv]["crateID"] = self.puid

	# submit: faction
	dataset = {
		"data_puid": self.puid,
		"data_faction": self.cData["faction"]
		}
	asc_g_msg.sendMsg("player_faction_set", dataset, self.sData.con_gameServer)

	# filter out all the equipped Gear and send it as a "special" set to the Server, so the Client can be equipped
	listGear = []
	for itemID in self.cData["itemData"]:
		item = self.cData["itemData"][itemID]
		# noinspection PyTypeChecker
		parentData = inv_handler.item_baseData_get(sData=self.sData, subTypeName=item["subType"])
		slot = parentData["baseData"]["slot"][0]
		PRINT_ATTENTION(f"parentData: {parentData}")

		inv = self.cData["inventory"][slot]
		# noinspection PyTypeChecker
		isSlot = inv["isSlot"]
		if isSlot != "1000":
			# noinspection PyTypeChecker
			if inv["slotsUsed"]:
				className = parentData["baseData"]["class_name"]
				PRINT_ATTENTION(f"[slot, className]: {[slot, className]}")
				listGear.append([slot, className])
	PRINT_ATTENTION(f"listGear: {listGear}")

	# Server:
	# send Player Dataset over to the Server, so it can set up the player:
	PRINT_DEBUG(f"SENDING: DATASET FROM {self.puid} TO GAMESERVER...")

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

	# send the item definitions
	PRINT_DEBUG(f"SENDING: ITEM BASE DATA TO {self.puid}... ")
	# send the base item Data
	asc_g_msg.sendMsg("INIT_ITEM_DATA", self.sData.itemParentData, self.con_client)
	PRINT_OK(f"SENDING: ITEM BASE DATA TO {self.puid}... DONE")

	PRINT_DEBUG(f"SENDING: ITEM CLASS DATA TO {self.puid}... ")
	# Send the formatted ItemClasses (Base+SubType merged together)
	asc_g_msg.sendMsg("INIT_ITEM_DATA", self.sData.itemClasses, self.con_client)
	PRINT_OK(f"SENDING: ITEM CLASS DATA TO {self.puid}... DONE")

	# Gear:
	PRINT_DEBUG(f"SENDING: INVENTORY ITEMDATA TO {self.puid}...")
	dataset = {
			"itemData": self.cData["itemData"],
			"inventory": self.cData["inventory"]
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
			PRINT_WARNING(f"players_stat_update: ERROR: {e}")

	database.asc_db.db_save(sData.database)


def player_update_faction(sData, *data):
	puid, faction = data
	pData = player_data_get(sData, puid)
	PRINT_DEBUG(f"player_update_faction: {puid} joined faction {faction} (previous: {pData['faction']})")
	pData["faction"] = faction
	# save to file
	database.asc_db.db_save(sData.database)


def player_killed(sData, *data):
	puid, dropCrateID = data
	# move all Items from the Client to the newly created "dropCrate" - crate was created earlier by the Server
	cData = player_data_get(sData, puid)
	client = sData.userlist[puid]
	crateData = sData.database.sessionCrates[dropCrateID]
	PRINT_DEBUG(f"crateData: {crateData}")
	# inv_crate_create(sData, clientID: str = None, pos: list = None, crateID: str = "", lootType: str = None, isLootcrate: int = 0, persistent: int = 0, loot_count: int = DEFAULT_loot_count, inv_rows: int = 20, inv_cols: int = 8, model: str = "IG_supplyCrate_F")

	# avoid runtime Error (due to dict changing, during the for loop)
	items_cData = list(cData["itemData"])
	for itemID in items_cData:
		itemData = cData["itemData"][itemID]

		# "move" the Items to the newly created Crate
		invSubID_old = itemData["invSub"]
		isFlipped = itemData["isFlipped"]

		parentData = inv_handler.item_baseData_get(sData=sData, subTypeName=itemData["subType"])
		# PRINT_ATTENTION(f"player_killed - parentData: {parentData}")
		# get the usedSlots
		# usedSlots_cur = inv_handler.inv_slots_used_get(invData=crateData["inventory"], invSubID="1000")
		PRINT_ATTENTION(f'crateData["inventory"] - {crateData["inventory"]}')
		usedSlots_cur = crateData["inventory"]["1000"]["slotsUsed"]

		# get Inventory sizes and make it an [row,col]-list
		invSize = [crateData["inventory"]["1000"]["inv_rows"], crateData["inventory"]["1000"]["inv_cols"]]
		# PRINT_ATTENTION(f'player_killed - parentData["baseData"]: {parentData["baseData"]}')

		# "Find free slot"
		invPos_new = inv_handler.item_slots_free_find(invDataSize=invSize, itemSize=parentData["baseData"]["size"], slotsUsed=usedSlots_cur, slotsIgnore=[], isFlipped=isFlipped)
		inv_handler.item_move(client=client, itemID=itemID, invID_old=puid, invSubID_old=invSubID_old, invID_new=dropCrateID, invSubID_new="1000", invPos_new=invPos_new[0], isFlipped=isFlipped)

	cData["itemData"] = {}
	# reset the grid of the player to the Standard Value:
	for inv in cData["inventory"]:
		invData_tmp = cData["inventory"][inv]
		if invData_tmp["isSlot"] == 0:
			invData_tmp["inv_rows"] = 0
			invData_tmp["inv_cols"] = 0
			invData_tmp["slotsUsed"] = []

	# add Starter Gear:
	startGear = ["vn_b_uniform_macv_01_06", "vn_b_bandana_03"]
	for itemName in startGear:
		item = inv_handler.item_create(sData=sData, itemSubTypeName=itemName)
		parentData = inv_handler.item_baseData_get(sData=sData, subTypeName=item["subType"])
		slot = parentData["baseData"]["slot"][0]
		inv_handler.inv_item_new_add(sData=sData, invData=cData, item=item, invSubID=slot, crateID=puid)

	# force-update the player Inventory, so all the values will be reset
	# Does NOT trigger the reopening of the Inventory, since player is dead!
	inv_handler.inv_data_update_force(client, dropCrateID, puid)

	# save to file
	# ToDo: finally add some proper "DB-saver"
	database.asc_db.db_save(sData.database)

# ToDo: Recheck - Inventory Handling updated!
def player_respawned(sData, puid):
	PRINT_ATTENTION(f"PLAYER_RESPAWNED: puid: {puid}")
	cData = player_data_get(sData, puid)
	listGear = []
	for x in cData["itemData"]:
		# noinspection PyTypeChecker
		slotID = cData["itemData"][x]["invSub"]

		if cData["inventory"][slotID]["isSlot"] == "1":
			listGear.append(cData["itemData"][x])
	# submit: loadout
	dataset = {
		"data_puid": puid,
		"data_gear": listGear
		}
	asc_g_msg.sendMsg("player_loadout_set", dataset, sData.con_gameServer)
