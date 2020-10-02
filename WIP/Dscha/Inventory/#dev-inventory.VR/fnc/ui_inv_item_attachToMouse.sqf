/*
	Attach the active ctrl to the Mouse.
	An additional offset is added, so the active ctrl is ALWAYS under the Cursor!
*/

private _ctrl = uinamespace getVariable ["an_ctrl_active", controlNull];
// remove if "grabbing" not active anymore. Reset the Var and delete the used control too.
if(!an_ui_inv_grabActive)then
{
	removeMissionEventHandler ["Draw3D", _thisEventhandler];
	
	// Deleting will be handled by ui_inv_mPos, after it took all the data
	ctrlDelete _ctrl;
	uinamespace setVariable ["an_ctrl_active",controlNull];
};
getMousePosition params["_mPos_x","_mPos_y"];

// systemchat str [an_ui_inv_grabActive, _ctrl];
private _offset = 0.005;

_ctrl ctrlSetPositionX (_mPos_x-_offset);
_ctrl ctrlSetPositionY (_mPos_y-(_offset*getResolution#4));	// AspectRatio stuff
_ctrl ctrlCommit 0;