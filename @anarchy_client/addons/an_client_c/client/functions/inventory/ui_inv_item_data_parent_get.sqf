
/*
	get and return the Parent data from the hashmap
	
	[["comment","Weapontype: Rifle"],["image",""],["class_name","vn_m14"],["name",""],["baseClass","base_wpn_primary"]]
	[["itemData",[["condition",150]]],["mainParent",""],["subParent","vn_m14"]]
	[["itemData",[["condition",100]]],["parentData",[["actions",[]],["attachments",[["muzzle",""],["scope",""]]],["wear",1]]],["mainParent","vn_m14_base"],["subParent",""]]
	
	Return:
	[
		["baseData",
			[
				 ["baseClass","base_wpn_primary"]
				,["class_name","vn_m14"]
				,["comment","Weapontype: Rifle"]
				,["image",""]
				,["name",""]
				,["size",[3,6]]
				,["slot",["2002","2202"]]
			]
		],
		["itemData",
			[
				["condition",150]
			]
		],
		["parentData",
			[
				["actions",
					[
						 ["repair",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]
						,["unjam",["STR_PLACEHOLDER","AN_C_FNC_PLACEHOLDER",0,[]]]
					]
				],
				["attachments",
					[
						 ["muzzle",""]
						,["scope",""]
					]
				],
				["wear",1]
			]
		],
		["mainParent","vn_m14_base"],
		["subParent",""]
	]
	
*/

params["_itemData"];

AN_data_itemData_base get (_itemData get "subType")
