private ["_cargo_test","_veh_tempcounter","_bbr","_p1","_p2","_maxWidth","_maxLength","_maxHeight"];

_veh_tempcounter = 0;

if (isNil "demiGOD") then {
	demiGOD = 0;
};
if (isNil ("IDC_cargo_towed")) then {
	IDC_cargo_towed = objNull;
};
if (isNil ("IDC_undo_towed_pos")) then {
	IDC_undo_towed_pos = [];
};
if (isNil ("IDC_undo_towed_dir")) then {
	IDC_undo_towed_dir = 0;
};
if (isNil ("IDC_auto_z")) then {
	IDC_auto_z = 0;
};
if (isNil ("IDC_search_dist")) then {
	IDC_search_dist = 10;
};
if (isNil ("IDC_object_types")) then {
	IDC_object_type_mode = 0;

	IDC_object_types = ["AllVehicles"];
	IDC_object_types = IDC_object_types + dayz_allowedObjects;
	IDC_object_types = IDC_object_types + DZE_isNewStorage;
	
	
	IDC_default_object_types = IDC_object_types;
};


if (isNull (IDC_cargo_towed)) then {

	_cargo_test = nearestObjects [player, IDC_object_types, IDC_search_dist];

	if ((count _cargo_test)>1) then {
		{
			_veh_tempcounter = _veh_tempcounter + 1;
			if (_veh_tempcounter == 2) then {
				if (!isNull (_x)) then {
					IDC_cargo_towed = _x;

					IDC_undo_towed_pos = getPosATL _x;						
					IDC_undo_towed_dir = getDir _x;

					_bbr = boundingBox _x;
					_p1 = _bbr select 0;
					_p2 = _bbr select 1;

					_maxLength = (abs (((_p2 select 1) - (_p1 select 1))/2) + 2);
					_maxWidth = 0;	
					_maxHeight = (abs (((_p2 select 2) - (_p1 select 2))/2) + 0.2);		

					if (!(IDC_cargo_towed isKindOf "Man")) then {
						if (!isNull (IDC_cargo_towed)) exitWith{TitleText [format["Picked up %1!",(typeOf IDC_cargo_towed)], "PLAIN DOWN"]; IDC_cargo_towed allowDamage false; IDC_cargo_towed attachTo [vehicle player, [_maxWidth, _maxLength, _maxHeight]];};	
					} else {
						IDC_cargo_towed = objNull;					
					};				
					
				};
			};
		} forEach _cargo_test;
	} else {
		TitleText ["Couldn't Find Object To Pick Up!", "PLAIN DOWN"];	
	};
	
} else {
	TitleText [format["Already Holding %1!",(typeOf IDC_cargo_towed)], "PLAIN DOWN"];
};


if (!isNull (IDC_cargo_towed)) then {
	player reveal IDC_cargo_towed;	
	if (demiGOD == 0) then {
		fnc_usec_damageHandler = {};
		fnc_usec_unconscious  = {};
		player removeAllEventHandlers "handleDamage";
		player addEventHandler ["handleDamage", {false}];
		player allowDamage false;
	};
	
	hint "-  (Rotate CClock)\n=   (Rotate Clock)\nShft -   (Move In)\nShft = (Move Out)\nPgUp     (Hght +)\nPgDn     (Hght -)\nShft PgUp(Fast Hght +)\nShft PgDn(Fast Hght -)\n[     (Place Type)\nShft [ (Object Types)\nCtrl -  (Search -)\nCtrl =  (Search +)";

	firstvector = [[0,1,0],[0.125,0.875,0],[0.25,0.75,0],[0.375,0.625,0],[0.5,0.5,0],[0.625,0.375,0],[0.75,0.25,0],[0.875,0.125,0],[1,0,0],[0.875,-0.125,0],[0.75,-0.25,0],[0.625,-0.375,0],[0.5,-0.5,0],[0.375,-0.625,0],[0.25,-0.75,0],[0.125,-0.875,0],[0,-1,0],[-0.125,-0.875,0],[-0.25,-0.75,0],[-0.375,-0.625,0],[-0.5,-0.5,0],[-0.625,-0.375,0],[-0.75,-0.25,0],[-0.875,-0.125,0],[-1,0,0],[-0.875,0.125,0],[-0.75,0.25,0],[-0.625,0.375,0],[-0.5,0.5,0],[-0.375,0.625,0],[-0.25,0.75,0],[-0.125,0.875,0]];	
	firstvector_ele = 0;
	firstvector_arr = [0,0,0];

	tempmaxWidth = _maxWidth;
	tempmaxLength = _maxLength;	
	tempmaxHeight = _maxHeight;

	keyDownCClock = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 12 && !(_this select 2) && !(_this select 3)) then {firstvector_ele = firstvector_ele - 1; if (firstvector_ele < 0) then {firstvector_ele = 31;}; firstvector_arr = firstvector select firstvector_ele; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];
	keyDownClock = 	(findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 13 && !(_this select 2) && !(_this select 3)) then {firstvector_ele = firstvector_ele + 1; if (firstvector_ele > 31) then {firstvector_ele = 0;}; firstvector_arr = firstvector select firstvector_ele; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];
	
	keyDownin = 	(findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 12 && (_this select 2) && !(_this select 3)) then {tempmaxLength = tempmaxLength - 0.1; IDC_cargo_towed attachTo [vehicle player, [tempmaxWidth, tempmaxLength, tempmaxHeight]]; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];
	keyDownout = 	(findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 13 && (_this select 2) && !(_this select 3)) then {tempmaxLength = tempmaxLength + 0.1; IDC_cargo_towed attachTo [vehicle player, [tempmaxWidth, tempmaxLength, tempmaxHeight]]; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];

	keyDownless = 	(findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 12 && (_this select 3) && !(_this select 2)) then {IDC_search_dist = IDC_search_dist - 1; if (IDC_search_dist < 3) then {IDC_search_dist = 3;}; TitleText [format[""Future Search Distance [%1]"",IDC_search_dist], ""PLAIN DOWN""];}"];
	keyDownmore = 	(findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 13 && (_this select 3) && !(_this select 2)) then {IDC_search_dist = IDC_search_dist + 1; TitleText [format[""Future Search Distance [%1]"",IDC_search_dist], ""PLAIN DOWN""];}"];
	
	keyDownPgUp = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 201 && !(_this select 2)) then {tempmaxHeight = tempmaxHeight + 0.1; IDC_cargo_towed attachTo [vehicle player, [tempmaxWidth, tempmaxLength, tempmaxHeight]]; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];
	keyDownPgDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 209 && !(_this select 2)) then {tempmaxHeight = tempmaxHeight - 0.1; IDC_cargo_towed attachTo [vehicle player, [tempmaxWidth, tempmaxLength, tempmaxHeight]]; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];

	keyDownPgUpFast = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 201 && (_this select 2)) then {tempmaxHeight = tempmaxHeight + 2; IDC_cargo_towed attachTo [vehicle player, [tempmaxWidth, tempmaxLength, tempmaxHeight]]; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];
	keyDownPgDownFast = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 209 && (_this select 2)) then {tempmaxHeight = tempmaxHeight - 2; IDC_cargo_towed attachTo [vehicle player, [tempmaxWidth, tempmaxLength, tempmaxHeight]]; IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];}"];

	keyAutoZ = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 26 && !(_this select 2)) then {if (IDC_auto_z == 0) then {IDC_auto_z = 1; TitleText [""Auto Z-axis [Save At Current Level]"", ""PLAIN DOWN""];} else {if (IDC_auto_z == 1) then {IDC_auto_z = 2; TitleText [""Auto Z-axis [Save At Building/Structure Level]"", ""PLAIN DOWN""];} else {IDC_auto_z = 0; TitleText [""Auto Z-axis [Save At Ground Level]"", ""PLAIN DOWN""];};};}"];

	keyObjectTypes = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 26 && (_this select 2)) then {if (IDC_object_type_mode == 0) then {IDC_object_type_mode = 1; IDC_object_types = [""All""]; TitleText [""Pick Up Object Types [All]"", ""PLAIN DOWN""];} else {IDC_object_type_mode = 0; IDC_object_types = IDC_default_object_types; TitleText [""Pick Up Object Types [Default]"", ""PLAIN DOWN""];};}"];
	
	while {!isNull (IDC_cargo_towed)} do {
		if ((firstvector_arr select 0 != 0) || (firstvector_arr select 1 != 0)) then {
			IDC_cargo_towed setVectorDirAndUp [[firstvector_arr select 0, firstvector_arr select 1, firstvector_arr select 2],[0, 0, 1]];
		};
		sleep 0.0001;
	};
	hint "";
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownCClock]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownClock]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownin]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownout]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownless]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownmore]; 	
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownPgUp]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownPgDown];
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownPgUpFast]; 
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyDownPgDownFast]; 	 	
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyAutoZ];
	(finddisplay 46) displayRemoveEventHandler ['KeyDown',keyObjectTypes]; 		
	keyDownCClock = objNull;
	keyDownClock = objNull;
	keyDownin = objNull;
	keyDownout = objNull;	
	keyDownless = objNull;
	keyDownmore = objNull;		
	keyDownPgUp = objNull;
	keyDownPgDown = objNull;
	keyDownPgUpFast = objNull;
	keyDownPgDownFast = objNull;	
	keyAutoZ = objNull;		
	keyObjectTypes = objNull;		
};
