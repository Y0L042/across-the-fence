/*
    File: para_player_init_client.sqf
    Author: Spoffy
    Date: 2020-10-12
    Last Update: 2020-10-12
    Public: Yes
    
    Description:
		Called on the client after player_init_server has finished.
		Serverside player initialisation is done at this point.
		Used for setting up UI elements, local event handlers, etc.
    
    Parameter(s):
        _player - Player to initialise [OBJECT]
		_didJIP - Whether the player joined in progress [BOOLEAN]
    
    Returns:
		None
    
    Example(s):
		//description.ext
		use_paradigm_init = 1;
*/

params ["_player", "_didJIP"];

diag_log "Anarchy: Player init client";