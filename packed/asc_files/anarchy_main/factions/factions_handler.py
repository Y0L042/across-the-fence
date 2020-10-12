

# update the points of a faction. points can either be positive or negative
def faction_stats_update(sData, *args):
	print(f"faction_upd_int called: args {args}")
	stat, faction, points = args
	# get the faction data
	fData = sData.database.faction_data_get(faction)
	# update intelligence
	points_cur = fData[stat]
	# print("points_cur", points_cur)
	fData[stat] = points_cur + points
	# print('fData["int"]', fData["int"])
	# Update the data in the database and trigger a "save to file"
	sData.database.faction_data_set(faction=faction, data=fData)


