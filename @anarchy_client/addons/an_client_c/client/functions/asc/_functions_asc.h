#include "..\fnc_macros_c.h"

class ASC
{
    DECLARE_CLIENT_FUNC_POSTINIT(asc,DEV_init);
    DECLARE_CLIENT_FUNC(asc,clientData_init);
    DECLARE_CLIENT_FUNC(asc,ext_CE_callback_client);
};
