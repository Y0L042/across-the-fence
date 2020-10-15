



params ["_item_size"];
private _size_array = [];
for "_row" from 0 to ((_item_size#0)-1) do	//Index start 0 == -1 = correct Index Pos
{
	for "_col" from 0 to ((_item_size#1)-1) do	//Index start 0 == -1 = correct Index Pos
	{
		_size_array pushback [_row,_col];
	};
};
_size_array
