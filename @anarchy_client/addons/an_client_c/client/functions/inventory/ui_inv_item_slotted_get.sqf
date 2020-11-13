/*
	Get the list with all Items in a Equipment Slot


[] spawn
{
	sleep 3;
	private _items = [] call an_c_fnc_ui_inv_item_slotted_get;
	{
		_msg = _x;
		systemChat str _msg;
		diag_log _msg;
	}forEach _items;
};

_items =
[
//	[ID, [ItemData]]]
	[10, [["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0xMS0wN1QwMToxMjoyMC45MTk1ODMtMjI="],["inSlot",10],["invPos",[0,0]],["isFlipped",0],["parent","vn_b_helmet_m1_01_01"]]]
	[3,	 [["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0xMS0wNFQxNzo0MDo1NS44MDYwMTktMw=="],["inSlot",3],["invPos",[0,0]],["isFlipped",0],["parent","vn_hd"]]]
	[12, [["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0xMS0wNFQxNzoxNDo0OC40MzQzNzAtMw=="],["inSlot",12],["invPos",[0,0]],["isFlipped",0],["parent","vn_b_uniform_macv_01_06"]]]
	[13, [["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0xMS0wNVQwNTo1NToyNC40MzY2MDAtNjE="],["inSlot",13],["invPos",[0,0]],["isFlipped",0],["parent","vn_b_vest_aircrew_01"]]]
	[15, [["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0xMS0wNVQwNjo1Nzo0NC4yNTI1MDUtMzc="],["inSlot",15],["invPos",[0,0]],["isFlipped",0],["parent","vn_o_pack_02"]]]
	[2,	 [["attachments",[]],["curInv","76561197960553643"],["hp_cur",100],["hp_max",100],["id","MjAyMC0xMS0wNFQxNzo0MzoxNC4wNjg5MjctMTQ="],["inSlot",2],["invPos",[0,0]],["isFlipped",0],["parent","vn_m16"]]]
];

*/

private _ret = localNamespace getVariable ["an_cData_invData_slotted",[]];
_ret


