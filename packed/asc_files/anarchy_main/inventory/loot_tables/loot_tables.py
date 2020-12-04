import json
import os
from printHandler import *

def load_files(sData):
	# ####### load the Loottables
	path = os.path.dirname(__file__)
	PRINT_STATUS(f'#### Loading loot-tables...')
	# get all files in the directory
	json_files = [pos_json for pos_json in os.listdir(path) if pos_json.endswith('.json')]
	for filename in json_files:
		try:
			# load the .json file
			with open(f"{path}\{filename}", "r") as file:
				# add the .json data to the sData dict
				jsonData = json.load(file)
				for key in jsonData:
					sData.lootData["tables"][key] = jsonData[key]

		except Exception as e:
			PRINT_WARNING(filename)
			PRINT_WARNING(f"ERROR: LOAD_FILES: Could not load filename: {filename} - Error: {e}")
	PRINT_OK(f'#### Loading loot-tables... done')