private ["_objectID","_objectUID","_classname"];

if (isNil ("IDC_cargo_towed")) then {
	IDC_cargo_towed = objNull;
};

if (isNil "demiGOD") then
{
	demiGOD = 0;
};

if (!isNull (IDC_cargo_towed)) then {
	_objectID 	= IDC_cargo_towed getVariable ["ObjectID","0"];
	_objectUID	= IDC_cargo_towed getVariable ["ObjectUID","0"];
	_classname = (typeOf IDC_cargo_towed);
	
	detach IDC_cargo_towed;
	IDC_cargo_towed allowDamage true;	
		
	if (!(IDC_cargo_towed isKindOf "Man")) then {		
		deleteVehicle IDC_cargo_towed;
		dayzDeleteObj = [_objectID,_objectUID];
		publicVariableServer "dayzDeleteObj";

		TitleText [format["Deleted %1!", _classname], "PLAIN DOWN"];			
	};

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

