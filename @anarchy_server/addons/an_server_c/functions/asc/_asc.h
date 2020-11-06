#include "..\fnc_macros_s.h"

class ASC
{
    DECLARE_SERVER_FUNC_INIT(asc,asc_init);
    DECLARE_SERVER_FUNC(asc,asc_address_set);
    DECLARE_SERVER_FUNC(asc,asc_player_init);
    DECLARE_SERVER_FUNC(asc,key_create);
    DECLARE_SERVER_FUNC(asc,player_connected);
    DECLARE_SERVER_FUNC(asc,player_disconnected);
    DECLARE_SERVER_FUNC(asc,ext_CE_callback_server);
    DECLARE_SERVER_FUNC(asc,update_players);
};
