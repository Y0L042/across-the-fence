from asc_fnc.asc_db import database

# update the points of a faction. points can either be positive or negative
def faction_stats_update(sData, *args):
	print(f"faction_upd_int called: args {args}")
	stat, faction, points = args
	# get the faction data
	fData = faction_data_get(sData, faction)
	# update intelligence
	points_cur = fData[stat]
	# print("points_cur", points_cur)
	fData[stat] = points_cur + points
	# print('fData["int"]', fData["int"])
	# Update the data in the database and trigger a "save to file"
	faction_data_set(sData=sData, faction=faction, data=fData)


def faction_data_get(sData, faction):
	print("faction_data_get: faction:", faction)
	# print(self.factions)
	try:
		fData = sData.database.factions[faction]
	except KeyError:
		fData = {}
	return fData


def faction_data_set(sData, faction: str = None, data: dict = None):
	print(f"faction_data_set: Faction: {faction} - Data: {data}")
	if None in [faction, data]:
		print(f"ERROR: faction_data_set: NOT FACTION OR DATA GIVEN: {faction} - {data}")
		return
	try:
		sData.database.factions[faction] = data
		database.asc_db.db_save(sData.database)
	except KeyError:
		print(f"ASC_DB: faction [{faction}] not found!")
		pass
