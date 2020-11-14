#include "..\fnc_macros_s.h"

class looting 
{
    DECLARE_SERVER_FUNC(looting,loot_request_crate_inventory);
	DECLARE_SERVER_FUNC(looting,loot_items_dropped);
	DECLARE_SERVER_FUNC(looting,loot_last_pos_set);
	DECLARE_SERVER_FUNC(looting,loot_last_pos_get);
    DECLARE_SERVER_FUNC(looting,lootseed_set);
};

