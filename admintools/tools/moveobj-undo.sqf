private ["_classname","_final_location","_retrycounter","_built_location"];

if (isNil ("IDC_cargo_towed")) then {
	IDC_cargo_towed = objNull;
};
if (isNil "demiGOD") then
{
	demiGOD = 0;
};
if (isNil ("IDC_undo_towed_pos")) then {
	IDC_undo_towed_pos = [];
};
if (isNil ("IDC_undo_towed_dir")) then {
	IDC_undo_towed_dir = 0;
};


if (!isNull (IDC_cargo_towed)) then {
	detach IDC_cargo_towed;
	
	_classname = (typeOf IDC_cargo_towed);

//	IDC_cargo_towed setDir IDC_undo_towed_dir;	
//	IDC_cargo_towed setPos [IDC_undo_towed_pos select 0, IDC_undo_towed_pos select 1, IDC_undo_towed_pos select 2];	

	IDC_cargo_towed setDir IDC_undo_towed_dir;		
	IDC_cargo_towed setPosATL [IDC_undo_towed_pos select 0, IDC_undo_towed_pos select 1, IDC_undo_towed_pos select 2];
	sleep 0.1;

	_final_location = getPosATL IDC_cargo_towed;
	_retrycounter = 0;
	while {((abs ((_final_location select 0) - (IDC_undo_towed_pos select 0)) > 0.05) || (abs ((_final_location select 1) - (IDC_undo_towed_pos select 1)) > 0.05) || (abs ((_final_location select 2) - (IDC_undo_towed_pos select 2)) > 0.05) || (((abs(_final_location select 0) == 0) || (abs(_final_location select 0) == 1)) && ((abs(_final_location select 1) == 0) || (abs(_final_location select 1) == 1))))  && (!(_retrycounter > 500))} do {
		IDC_cargo_towed setDir IDC_undo_towed_dir;		
		IDC_cargo_towed setPosATL [IDC_undo_towed_pos select 0, IDC_undo_towed_pos select 1, IDC_undo_towed_pos select 2];
		sleep 0.01;
		_final_location = getPosATL IDC_cargo_towed;
		_retrycounter = _retrycounter + 1;		
	};	
	
	if (IDC_auto_z == 0) then {
		_built_location = IDC_cargo_towed modelToWorld [0,0,0];				
		IDC_cargo_towed setPos [_built_location select 0, _built_location select 1, 0];				
	};
	
	player reveal IDC_cargo_towed;	
	IDC_cargo_towed allowDamage true;	

	TitleText [format["Undo Pickup Of %1 Complete!", _classname], "PLAIN DOWN"];


/*
	sleep 1;
	_final_location = getPosATL IDC_cargo_towed;

	TitleText [format["Vehicle At: %1, %2, %3 / Supposed To Be At: %4, %5, %6 / Counter: %7", _final_location select 0, _final_location select 1, _final_location select 2, IDC_undo_towed_pos select 0, IDC_undo_towed_pos select 1, IDC_undo_towed_pos select 2, _retrycounter], "PLAIN DOWN"];	
*/


	IDC_undo_towed_pos = [];	
	IDC_undo_towed_dir = 0;	
	IDC_cargo_towed = objNull;
	
	if (demiGOD == 0) then {
		fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
		fnc_usec_unconscious = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_unconscious.sqf";
		player addEventHandler ["handleDamage", {true}];
		player removeAllEventHandlers "handleDamage";
		player allowDamage true;
	};			

} else {
	TitleText ["No Object Currently Picked Up, Skipping!", "PLAIN DOWN"];
};

