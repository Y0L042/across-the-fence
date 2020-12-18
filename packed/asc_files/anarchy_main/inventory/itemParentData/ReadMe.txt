# All _BASE definitions MUST be placed in: "..\asc_files\anarchy_main\inventory\itemParentData\Filename.json".
# All SUBTYPES (the one, that will be added to the loot-tables), MUST be placed in the Subfolder: "\subtypes\filename.json"
# Technically, it doesn't matter how many files you have. Everything with the .json ending will be loaded in!
# So theoratically, you could merge everything into one file, but that makes it pretty messy, don't you think?


Examples for Item definitions:

BaseClass:
{
	"base_wpn_primary":             # ! primary Keys == standard for EVERY Baseclass !
	{
		"size": [3, 6],             # item size - unless it gets overwritten by the sub-ParentData.
		"slot": [2002,2202],        # The slots in which the item can be placed in
	},
	"base_item":
	{
		"size": [1, 1],
		"slot": [0],
	},
}


BaseParent:
{
	"vn_m14_base":                          # ! primary Keys == standard for EVERY Baseclass !
	{
		"size": [2, 4],                     # overrides the original "size" data!
		# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		# "slot": [999],                    # Slot will ALWAYS use the baseClass entry! It can NEVER be overwritten!
		# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		"baseClass": "base_wpn_primary",	# Insert the defined BaseClass here
		"class_name": "vn_m14",             # Arma Config name - !! NEEDED for wearable Gear like Weapons, Uniforms, Vests, etc. !!
		"name": "",                         # display-name (optional: Will be used, instead of the displayName in the A3 Config)
		"image": "",                        # image-path to File (optional: Will be used, instead of the image path in the A3 Config)
		# !!! WARNING !!!
		# .json does NOT SUPPORT Comments, so we abuse it, by just simply adding an extra key for it
		"comment": "My comment"				# Can be any text or whatever. E.g. for sorting/notes etc. Won't be checked/used anyway
	},

	"vn_m14_base_b":                        # ! primary Keys == standard for EVERY Baseclass !
	{
		"size": [3, 6],                     # overrides the original "size" data!
		"baseClass": "base_wpn_primary",
		"class_name": "vn_m14",             # Arma Config name - !! NEEDED for wearable Gear like Weapons, Uniforms, Vests, etc. !!
		"name": "",                         # display-name (optional: Will be used, instead of the displayName in the A3 Config)
		"image": "",                        # image-path to File (optional: Will be used, instead of the image path in the A3 Config)
		"comment": "My comment"				# Can be any text or whatever. E.g. for sorting/notes etc. Won't be checked/used anyway
	},
	
	
	"mediKit_base":                         # ! primary Keys == standard for EVERY Baseclass !
	{
		"baseClass": "base_item",
		"size": [2, 2],                     # overrides the original "size" data!
		"class_name": "",					# No Classname set? -> Use "name" and "image"! If "name"  or "image" was set additonally, it overrides the Data of "class_name"!
		"name":       "STR_MediKit",
		"image":      "\\A3\\Weapons_F\\Items\\data\\UI\\gear_Medikit_CA.paa",	# "\\PATH\\TO\\IMAGE\\FILE\\IN\\ADDON" - "\\" - NOT: /, \ or anything else.
	}
}


SubTypes: # (Definitions MUST be placed in the SubFolder: "subtypes" )
{
	"vn_m14":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		# "parentData name" to use (data is located in "sData.itemParentData") - NOT PLACED IN LOOT-TABLE
		# !!! if set: "subParent" will be ignored !!!
		"mainParent": "vn_m14_base",

		# If empty: indicating that this is the subtype base and that the itemBase Data can be fetched from the baseclass, using its name
		"subParent": "",

		# define the standard values - Data will NOT be copied over to the created Item, only queried!
		"parentData":
		{
			"actions":
			{
			#	TAG:	[Text to display, Function to execute, 0=call/1=spawn, [additional parameter]]
				"unjam": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []],
				"repair": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []]
			},
			"attachments": {"scope": "", "muzzle": ""},
			"wear": 1
		},
		# Standard/Init Values
		# Data in here will be copied into the Item itself (so they will be editable)!
		# Additionally: All values will be inserted into "parentData", to be able to access them as "max/start values"
		"itemData":
		{
			"condition": 100,
			"someStuff": 321
		}
	},
	
	# another Weapon definition
	"vn_m14_b":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		# "parentData name" to use (data is located in "sData.itemParentData") - NOT PLACED IN LOOT-TABLE (will check if subParent is set, if added accidentally)
		# !!! if set: "subParent" will be ignored !!!
		"mainParent": "vn_m14_base_b",

		# If empty: indicating that this is the subtype base and that the itemBase Data can be fetched from the baseclass, using its name
		"subParent": "",

		# define the standard values - Data will NOT be copied over to the created Item, only queried!
		"parentData":
		{
			"actions":
			{
				"unjam": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []],
				"repair": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []]
			},
			"attachments": {"scope": "", "muzzle": ""},
			"wear": 1
		},
		# Standard/Init Values
		# Data in here will be copied into the Item itself (so they will be editable)!
		# Additionally: All values will be inserted into "parentData", to be able to access them as "max/start values"
		"itemData":
		{
			"condition": 100,
			"someStuff": 321
		}
	},
	
	# #################################################
	# #################################################
	
	# subType children
	"vn_m14_BetterCondition":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		"mainParent": "",
		# If set: This is a children, using all the data of the subType-parent
		"subParent": "vn_m14_b",
		# Changes in here will overwrite the subParent settings!
		"itemData":
		 {
			# changes the entry "condition" to 150 (instead of 100), but leaves "someStuff" as it is.
			"condition": 150
		 }
	},
	# subType children
	"vn_m14_noScopeLessWear":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		"mainParent": "",
		"subParent": "vn_m14",
		"parentData":
		{
			#  In this example: removing "scope" from "attachments"
			"attachments": {"muzzle": ""},
			# reducing the wear
			"wear": 0.5
		}
	},
	# subType children
	"vn_m14_noRepairLessWearBetterCondition":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		"mainParent": "",
		"subParent": "vn_m14_BetterCondition",
		"parentData":
		{
			"actions":
			{
				"unjam": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []]
			},
			"wear": 0.25
		},
		"itemData":
		 {
			"someStuff": 123
		 }
	},

	# subType children
	"mediKit":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		"mainParent": "mediKit_base",
		"subParent": "",
		"parentData":
		{
			"actions":
			{
				"use MediKit": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []]
			},
			"wear": 1
		},
		"itemData":
		{
			"someOtherStuff": 123
		}
	},

	# subType children
	"mediKit_b":	# <--- THIS CAN BE ADDED TO THE LOOT-TABLE !!!
	{
		"mainParent": "",
		"subParent": "mediKit",
		"parentData":
		{
			"actions":
			{
				"use MediKit": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []],
				"split MediKit": ["STR_PLACEHOLDER", "AN_C_FNC_PLACEHOLDER", 0, []]
			},
			"wear": 0.5
		},
		"itemData":
		{
			"someOtherStuff": 666
		}
	}
	
}