/*
    File: para_player_preinit_client.sqf
    Author: Spoffy
    Date: 2020-10-12
    Last Update: 2020-10-12
    Public: Yes
    
    Description:
		Called on the client once the player has joined the game.
		Only called once the player is ready to be initialised.
		Do things such as setting up loading screens here.
    
    Parameter(s):
        _player - Player that joined [OBJECT]
		_didJIP - Whether the player is JIPing [BOOLEAN]

    
    Returns:
		None
    
    Example(s):
        //In description.ext
        use_paradigm_init = 1;
*/

params ["_player", "_didJIP"];

diag_log "Anarchy: Preinit client";