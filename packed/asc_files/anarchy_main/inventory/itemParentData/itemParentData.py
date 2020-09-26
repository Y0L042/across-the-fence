import json
import os


def load_files(sData):
	# ####### load all the Items
	path = os.path.dirname(__file__)
	print(f'#### Loading itemData...')
	# get all files in the directory
	json_files = [pos_json for pos_json in os.listdir(path) if pos_json.endswith('.json')]
	for filename in json_files:
		try:
			# load the .json file
			with open(f"{path}\{filename}", "r") as file:
				# add every Base_ItemData to the sData.itemParentData
				data = json.load(file)
				for x in data:
					# print(f"DEBUG: ItemData: {data[x]}")
					sData.itemParentData[x] = data[x]
		except Exception as e:
			print(filename)
			print(f"ERROR: LOAD_FILES: Could not load filename: {filename} - Error: {e}")

	print(f'#### Loading itemData... done')

	# add a "placeholder" aka fallback Item:
	sData.itemParentData["PLACEHOLDER"] = {
				"size":        [2, 2],
				"slot":        0,
				"class_name":  "",
				"name":        "PLACEHOLDER",
				"image":       "\\vn\\ui_f_vietnam\\data\\logo\\savage_ca.paa",
				"addInvSpace": 0,
				"hp_max":      1,
				"tear":        0,
				"actions":     {}
			}
