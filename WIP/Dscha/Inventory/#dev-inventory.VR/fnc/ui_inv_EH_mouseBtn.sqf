

//executed from grabbed Item ctrl
disableSerialization;
params ["_ctrl", "_btn", "_xPos", "_yPos", "_btn_shift", "_btn_ctrl", "_btn_alt"];
systemchat str ["Btn:",_btn];

//RMB - Reset to old Pos
if(_btn == 1 && an_ui_inv_grabActive)then
{
	private _data_prev = _ctrl getVariable ["item_data_prev",[]];
	_data_prev_cur = +_data_prev;
	_data_prev_cur call an_fnc_ui_inv_item_create;
	an_ui_inv_grabActive = false;	//triggers the deletion of the temp Item
};

//LMB - Place Item
if(_btn == 0)then
{
	_this call an_fnc_ui_inv_mPos_check;
};

//NEEDED!
true