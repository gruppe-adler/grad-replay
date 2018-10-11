params ["_array"];

// diag_log "removing draw eh";

// delete icons frame before
if (count _array > 0) then {
    {
        ((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", _x];
    } forEach _array;
};
