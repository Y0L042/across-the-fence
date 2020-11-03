#include "..\fnc_macros_s.h"

class player 
{
    DECLARE_SERVER_FUNC(player,player_get_by_puid);
    DECLARE_SERVER_FUNC(player,player_pos_set);
    DECLARE_SERVER_FUNC(player,player_faction_set);
    DECLARE_SERVER_FUNC(player,player_health_set);
    DECLARE_SERVER_FUNC(player,player_loadout_set);
};

