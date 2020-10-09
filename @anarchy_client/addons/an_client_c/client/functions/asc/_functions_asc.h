#include "..\fnc_macros_c.h"

class ASC
{
    // ToDo: set "asc_init" to be called from the Server via remoteExec, so the initial Data Package can't be send before the CallbackEH is set up!
    DECLARE_CLIENT_FUNC_POSTINIT(asc,asc_init);
    DECLARE_CLIENT_FUNC(asc,clientData_init);
    DECLARE_CLIENT_FUNC(asc,ext_CE_callback_client);
};
