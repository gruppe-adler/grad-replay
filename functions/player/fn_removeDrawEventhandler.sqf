params ["_array"];

// delete icons frame before
if (count _array > 0) then {
	{
		((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", _x];
	} forEach _array;
};