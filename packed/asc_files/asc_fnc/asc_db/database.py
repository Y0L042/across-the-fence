import socket
from asc_fnc import timestamp
import json
from printHandler import *

class asc_db:
	def __init__(self, con_gameServer, dbPath, dbName):
		self.name = dbName
		self.dbPath = dbPath
		self.dbName = dbName
		self.lastUpdate = timestamp.timestamp_get()
		self.factions = {"WEST": {"INT": 0}, "EAST": {"INT": 0}, "GUER": {"INT": 0}, "CIV": {"INT": 0}}
		self.players = {}
		self.guilds = {}
		self.zones = {}
		# persistent storage
		self.crates = {}
		self.bases = {}
		# Temporary storage like Loot crates will be stored in here. Entries will NOT be saved to the Database!
		self.sessionCrates = {}

		PRINT_DEBUG("\n########################################################\n#### ASC: LOADING DATABASE\n")
		try:
			with open(f"{self.dbPath}{self.dbName}", "r", encoding="ascii") as f:
				self._db_load(json.load(f))
			PRINT_DEBUG("\n########################################################\n#### ASC: DATABASE found")
		except FileNotFoundError:
			try:
				PRINT_ATTENTION("\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n#### ASC: DATABASE HAS NOT been found - Creating new file\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n")
				# No file found, load the default Values
				_dbData = {"main": {"name": self.dbName, "lastUpdate": timestamp.timestamp_get()}, "players": {}, "guilds": {}, "zones": {}, "crates": {}, "bases": {}}
				self._db_load(_dbData)
				self.db_save()
			except FileNotFoundError:
				PRINT_WARNING("\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n#### ASC: DATABASE HAS NOT been found - PATH NOT FOUND!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n")
				con_gameServer.shutdown(socket.SHUT_RDWR)
				con_gameServer.close()
				self.name = None
				return
		except Exception as e:
			PRINT_WARNING(f"ASC DB: CLASS INIT: Exception:\n{e}")

	########################################################
	# "local" functions:
	# Don't meant to be called from outside!
	def _db_load(self, data):
		PRINT_DEBUG(f'DATABASE: Players in DB: {len(data["players"])}')
		self.players = data["players"]
		self.crates = data["crates"]


	def _db_updTime_(self):
		self.lastUpdate = timestamp.timestamp_get()

	########################################################
	# global functions:
	def db_get_name(self):
		return self.name

	def db_get_lastUpd(self):
		return self.lastUpdate

	def db_save(self):
		# PRINT_ATTENTION("preparing data to save")
		self._db_updTime_()
		with open(f"{self.dbPath}{self.dbName}", 'w+') as f:
			_dbData = {
				'main': {
						"name":       self.dbName,
						"lastUpdate": self.lastUpdate
					},
				'factions': self.factions,
				'players': self.players,
				'guilds': self.guilds,
				'zones': self.zones,
				'crates': self.crates,
				'bases': self.bases
				}
			# PRINT_OK("preparing data to save... done")

			# human easily readable format
			json.dump(_dbData, f, indent=4)
			# 1liner (less file size)
			# json.dump(_dbData, f)

			# PRINT_OK("saving done")
