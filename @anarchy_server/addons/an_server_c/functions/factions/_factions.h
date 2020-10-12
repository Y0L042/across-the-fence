
#include "..\fnc_macros_s.h"

class factions 
{
    DECLARE_SERVER_FUNC(factions, factions_create_recruiter);
    DECLARE_SERVER_FUNC(factions, factions_create_recruiters_at_markers);
    DECLARE_SERVER_FUNC(factions, factions_init);
    DECLARE_SERVER_FUNC(factions, factions_join_faction);
    DECLARE_SERVER_FUNC(factions, factions_recruiter_join_faction);
    DECLARE_SERVER_FUNC(factions, factions_set_player_to_faction);
    DECLARE_SERVER_FUNC(factions, factions_stats_update);
    DECLARE_SERVER_FUNC(factions, factions_data_load);
};

