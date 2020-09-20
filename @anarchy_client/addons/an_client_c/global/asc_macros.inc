
#define DATA_PARSE(d)	parseSimpleArray d
#define ENTRY_GET(e,d)	[e,d] call AN_G_fnc_data_get
#define ENTRY_GEAR_GETPARENT(e,d)	['parent',([e,d] call AN_G_fnc_data_get)] call AN_G_fnc_data_get