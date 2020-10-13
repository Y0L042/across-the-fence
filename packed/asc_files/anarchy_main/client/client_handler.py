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
		'health':   [
				["hitface", "hitneck", "hithead", "hitpelvis", "hitabdomen", "hitdiaphragm", "hitchest", "hitbody", "hitarms", "hithands", "hitlegs", "incapacitated"],
				["face_hub", "neck", "head", "pelvis", "spine1", "spine2", "spine3", "body", "arms", "hands", "legs", "body"],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			],
		'stats':    {
				"hunger": 0,
				"thirst": 0
			},
		'pos':      [
				[0, 0, 0],
				0,
			],
		'inv_grid': inv_handler.invGrid_create(4),
		'itemData': {},
		'gear':     {
			# 'helmet': {},
			'helmet': item_handler.item_create("vn_b_bandana_03"),   # DEV
			'goggles': {},
			# 'backpack': {},
			'backpack': item_handler.item_create("vn_c_pack_01"),   # DEV
			'vest': {},
			# 'uniform': {},
			'uniform': item_handler.item_create("vn_b_uniform_macv_01_06"),   # DEV
			'pouch': {},
			'tool': {},
			'w_main': {},
			'w_main_b': {},
			'w_hand': {},
			'w_launcher': {}
			},
		'ammo': {
				"ammoType_a": 0,
				"ammoType_b": 0,
				"ammoType_c": 0,
				"ammoType_d": 0
			}
		}

	cData.update(kwargs)
	cData["gear"]["helmet"]["curInv"] = cData["puid"]
	cData["gear"]["uniform"]["curInv"] = cData["puid"]
	cData["gear"]["backpack"]["curInv"] = cData["puid"]
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
	# send gear over to the Server, so it can equip the player:
	print(f"SENDING DATASET FROM {self.puid} TO SERVER...")
	dataset = {
		"data_puid": self.puid,
		"data_gear": self.cData["gear"]
		}
	asc_g_msg.sendMsg("loadout_set", dataset, self.sData.con_gameServer)
	print(f"SENDING DATASET FROM {self.puid} TO SERVER... DONE")


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