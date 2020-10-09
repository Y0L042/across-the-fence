
#define DECLARE_GLOBAL_FUNC(SUBFOLDER,FNAME) class FNAME {file = G_PATH(SUBFOLDER,FNAME); recompile = 1;}
#define DECLARE_GLOBAL_FUNC_INIT(SUBFOLDER,FNAME) class FNAME {file = G_PATH(SUBFOLDER,FNAME); init = 1; recompile = 1;}
#define DECLARE_GLOBAL_FUNC_PREINIT(SUBFOLDER,FNAME) class FNAME {file = G_PATH(SUBFOLDER,FNAME); preInit = 1; recompile = 1;}
#define DECLARE_GLOBAL_FUNC_POSTINIT(SUBFOLDER,FNAME) class FNAME {file = G_PATH(SUBFOLDER,FNAME); postInit = 1; recompile = 1;}
#define DECLARE_GLOBAL_FUNC_PRESTART(SUBFOLDER,FNAME) class FNAME {file = G_PATH(SUBFOLDER,FNAME); postInit = 1; recompile = 1;}

#define G_PATH(SUBFOLDER,FILENAME) \sgd\anarchy\an_client_c\global\functions\SUBFOLDER\FILENAME.sqf
