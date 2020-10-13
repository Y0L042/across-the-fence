
// update Pos, Health, ...
private _update_data = [];
{
	if(alive _x)then
	{
		private _puid = getPlayerUID _x;
		
		// get current pos and dir (precise positions)
		toFixed 8;
		private _data_pos = ["pos", [getPosWorld _x, getDir _x]];
		// get health
		toFixed 3;
		private _data_health = ["health", (getDammage _x)];
		// Reset toFixed back to normal
		toFixed -1;
		// get ...
		
		// store, so we can send over in one package
		_update_data pushback [_puid, [_data_pos, _data_health]];
	};
}forEach (allPlayers - entities "HeadlessClient_F");

//send the data to the backend
// diag_log ["DEBUG: update_players: SENDING DATA TO SERVER: ", _update_data];
if(count _update_data > 0)then
{
	["update_players", _update_data] call AN_G_fnc_msg_send;
};

