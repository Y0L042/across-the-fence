/*
	simple check if given vars are within a given range
	called by "ui_inv_grid_posToGrid"
	
	Input:
		[
			 curX	// FLOAT - x Pos to check
			,curY	// FLOAT - Y Pos to check
			,maxY	// FLOAT - Y max of Grid
		]
*/

// ------------ CHECKED
params["_t_row","_t_col","_g_y"];

//return negated result (True == False)
!(
	_t_col < 0 ||
	{_t_col > (8-1)} ||
	{_t_row < 0} ||
	{_t_row > (_g_y-1)}
)