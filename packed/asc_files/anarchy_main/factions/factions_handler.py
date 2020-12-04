from asc_fnc.asc_db import database
from printHandler import *

# update the points of a faction. points can either be positive or negative
def faction_stats_update(sData, *args):
	PRINT_DEBUG(f"DEBUG: faction_stats_update called: args {args}")
	stat, faction, points = args
	# get the faction data
	fData = faction_data_get(sData, faction)
	# update intelligence
	points_cur = fData[stat]
	# PRINT_DEBUG("points_cur", points_cur)
	fData[stat] = points_cur + points
	# PRINT_DEBUG('fData["int"]', fData["int"])
	# Update the data in the database and trigger a "save to file"
	faction_data_set(sData=sData, faction=faction, data=fData)


def faction_data_get(sData, faction):
	PRINT_DEBUG(f"DEBUG: faction_data_get: faction: {faction}")
	PRINT_DEBUG(sData.factions)
	try:
		fData = sData.database.factions[faction]
	except KeyError:
		PRINT_WARNING(f"ERROR: FACTION_DATA_GET: Faction data not found! Faction: {faction}")
		fData = {}
	return fData


def faction_data_set(sData, faction: str = None, data: dict = None):
	PRINT_DEBUG(f"DEBUG: faction_data_set: Faction: {faction} - Data: {data}")
	if None in [faction, data]:
		PRINT_WARNING(f"ERROR: faction_data_set: NOT FACTION OR DATA GIVEN: {faction} - {data}")
		return
	try:
		sData.database.factions[faction] = data
		database.asc_db.db_save(sData.database)
	except KeyError:
		PRINT_WARNING(f"ERROR: ASC_DB: faction [{faction}] not found!")
		pass
