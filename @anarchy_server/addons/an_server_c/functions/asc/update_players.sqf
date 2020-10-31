
// update Pos, Health, ...
private _updateData = [];
{
	if(alive _x)then
	{
		private _puid = getPlayerUID _x;
		
		// get current pos and dir (precise positions)
		toFixed 8;
		private _dataPos = ["pos", [getPosWorld _x, getDir _x, animationState _x]];
		// get health
		toFixed 3;
		private _dataHealth = ["health", (getDammage _x)];
		// Reset toFixed back to normal
		toFixed -1;
		
		// store, so we can send over in one package
		_updateData pushback [_puid, [_dataPos, _dataHealth]];
	};
}forEach (allPlayers - entities "HeadlessClient_F");

//send the data to the backend
// diag_log ["DEBUG: update_players: SENDING DATA TO SERVER: ", _updateData];
if(count _updateData > 0)then
{
	["update_players", _updateData] call AN_G_fnc_msg_send;
};

