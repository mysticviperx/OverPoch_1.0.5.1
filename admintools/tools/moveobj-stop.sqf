private ["_built_location","_dir","_classname","_objectID","_objectIDNum","_objectUID","_objectUIDNum","_characterID","_flagaddedallowed","_retrycounter","_lockable"];

if (isNil ("IDC_cargo_towed")) then {
	IDC_cargo_towed = objNull;
};
if (isNil "demiGOD") then {
	demiGOD = 0;
};
if (isNil ("IDC_auto_z")) then {
	IDC_auto_z = 0;
};

if (!isNull (IDC_cargo_towed)) then {
	
	detach IDC_cargo_towed;
	
	if (IDC_auto_z == 0) then {
//		_built_location = [((getPosATL IDC_cargo_towed) select 0), ((getPosATL IDC_cargo_towed) select 1), 0];
		_built_location = IDC_cargo_towed modelToWorld [0,0,0];
		_built_location set [2,0];
	} else {
		if (IDC_auto_z == 1) then {
			_built_location = [((getPosATL IDC_cargo_towed) select 0), ((getPosATL IDC_cargo_towed) select 1), ((getPosATL IDC_cargo_towed) select 2)];	
		} else {
			_built_location = IDC_cargo_towed modelToWorld [0,0,0];				
			if (abs ((_built_location select 2) - ((getPosATL IDC_cargo_towed) select 2)) > 1) then {
				_built_location set [2,(((getPosATL IDC_cargo_towed) select 2) - (_built_location select 2))];			
			};

		};
	};


	_retrycounter = 0;
	while {(((abs(_built_location select 0) == 0) || (abs(_built_location select 0) == 1)) && ((abs(_built_location select 1) == 0) || (abs(_built_location select 1) == 1)))  && (!(_retrycounter > 500))} do {
		if (IDC_auto_z == 0) then {
	//		_built_location = [((getPosATL IDC_cargo_towed) select 0), ((getPosATL IDC_cargo_towed) select 1), 0];
			_built_location = IDC_cargo_towed modelToWorld [0,0,0];
			_built_location set [2,0];
		} else {
			if (IDC_auto_z == 1) then {
				_built_location = [((getPosATL IDC_cargo_towed) select 0), ((getPosATL IDC_cargo_towed) select 1), ((getPosATL IDC_cargo_towed) select 2)];	
			} else {
				_built_location = IDC_cargo_towed modelToWorld [0,0,0];				
				if (abs ((_built_location select 2) - ((getPosATL IDC_cargo_towed) select 2)) > 1) then {
					_built_location set [2,(((getPosATL IDC_cargo_towed) select 2) - (_built_location select 2))];			
				};

			};
		};
		sleep 0.01;
		_retrycounter = _retrycounter + 1;		
	};	
	
	_classname = (typeOf IDC_cargo_towed);
	_objectID 	= IDC_cargo_towed getVariable ["ObjectID","0"];
	_objectIDNum 	= parseNumber (IDC_cargo_towed getVariable ["ObjectID","0"]);	
	_objectUID	= IDC_cargo_towed getVariable ["ObjectUID","0"];
	_objectUIDNum	= parseNumber (IDC_cargo_towed getVariable ["ObjectUID","0"]);	
	_characterID	= IDC_cargo_towed getVariable ["characterID","0"];	

	_lockable = 0;
	if(isNumber (configFile >> "CfgVehicles" >> _classname >> "lockable")) then {
		_lockable = getNumber(configFile >> "CfgVehicles" >> _classname >> "lockable");
	};	
	
	// Add to allowed update objects
	_flagaddedallowed = false;
	if (!(_classname in dayz_updateObjects) && _objectIDNum > 0) then {
		_flagaddedallowed = true;
		dayz_updateObjects	= dayz_updateObjects + [_classname];
	};
	
	_dir = getDir IDC_cargo_towed;
	player reveal IDC_cargo_towed;	
	IDC_cargo_towed allowDamage true;	

    if (!(IDC_cargo_towed isKindOf "Man")) then {

		if (IDC_auto_z == 1) then {		
			IDC_cargo_towed setPosATL [_built_location select 0, _built_location select 1, _built_location select 2];
		} else {
			IDC_cargo_towed setPos [_built_location select 0, _built_location select 1, _built_location select 2];		
		};

//		if (_classname == "VaultStorageLocked" || _classname == "VaultStorage") then {		
//			IDC_cargo_towed setVariable ["OEMPos",_built_location,true];
//		};

		IDC_cargo_towed setVariable ["OEMPos",_built_location,true];
		
		if (_objectIDNum > 0) then {
			if (IDC_auto_z == 0) then {		
				dayzUpdateVehicle = [IDC_cargo_towed, "positionnow-atl"];
			} else {
				dayzUpdateVehicle = [IDC_cargo_towed, "positionnow"];			
			};
			publicVariableServer "dayzUpdateVehicle";			
		
			TitleText [format["Dropped (Updated In DB) %1! (ID %2 / CID %3)", _classname, _objectID, _characterID], "PLAIN DOWN"];	
		} else {
			TitleText [format["Dropped (Not Updated In DB) %1! (ID %2 / CID %3)", _classname, _objectID, _characterID], "PLAIN DOWN"];				
		};

		IDC_cargo_towed = objNull;
		
		if (demiGOD == 0) then {
			fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
			fnc_usec_unconscious = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_unconscious.sqf";
			player addEventHandler ["handleDamage", {true}];
			player removeAllEventHandlers "handleDamage";
			player allowDamage true;
		};			
	};

	// Remove from allowed update objects
	if (_flagaddedallowed) then {
		_flagaddedallowed = false;
		dayz_updateObjects	= dayz_updateObjects - [_classname];
	};		
} else {
	TitleText ["No Object Currently Picked Up, Skipping!", "PLAIN DOWN"];
};

