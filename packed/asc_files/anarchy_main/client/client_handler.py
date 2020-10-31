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
				"hunger": 0,
				"thirst": 0
			},
		'pos':      [
				[0, 0, 0],
				0,
			],
		"faction": "CIV",   # Standard start faction
		'inv_grid': inv_handler.invGrid_create(8),
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

	# Server:
	# send Player Dataset over to the Server, so it can set up the player:
	print(f"SENDING DATASET FROM {self.puid} TO SERVER...")
	dataset = {
		"data_puid": self.puid,
		"data_pos": self.cData["pos"],
		"data_health": self.cData["health"],
		"data_faction": self.cData["faction"]
		}
	asc_g_msg.sendMsg("loadout_set", dataset, self.sData.con_gameServer)


	# Client:
	# send item Data
	print(f"SENDING INIT_ITEMDATA TO {self.puid}... ")
	asc_g_msg.sendMsg("INIT_ITEMDATA", self.sData.itemParentData, self.con_client)
	print(f"SENDING INIT_ITEMDATA TO {self.puid}... DONE")

	# send player Data
	print(f"SENDING INIT_CLIENTDATA TO {self.puid}...")
	asc_g_msg.sendMsg("INIT_CLIENTDATA", self.cData, self.con_client)
	print(f"SENDING INIT_CLIENTDATA TO {self.puid}... DONE")


def player_data_get(sData, puid):
	print("player_data_get: puid:", puid)
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
