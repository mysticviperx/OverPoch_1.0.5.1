private ["_classname","_posplr","_dirplr","_object","_objectID","_characterID","_characterIDNum","_keySelected","_bbr","_p1","_p2","_maxWidth","_maxLength","_y_offset"];

if (isNil ("IDC_cargo_towed")) then {
	IDC_cargo_towed = objNull;
};
if (isNil "demiGOD") then {
	demiGOD = 0;
};

if (!isNull (IDC_cargo_towed)) then {

	_bbr = boundingBox IDC_cargo_towed;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;

	_maxWidth = ((_p2 select 0) + 1);
	_maxLength = ((_p2 select 1) + 1);
	if (_maxWidth > _maxLength) then {
		_y_offset = _maxWidth + 1;
	} else {
		_y_offset = _maxLength + 1;	
	};
	
	_classname = (typeOf IDC_cargo_towed);
	_posplr = [((getPos player) select 0), ((getPos player) select 1) + _y_offset, 0];
//	_dirplr = getDir IDC_cargo_towed;
	_dirplr = getDir player;
	_objectID 	= parseNumber (IDC_cargo_towed getVariable ["ObjectID","0"]);
	_characterID	= IDC_cargo_towed getVariable ["CharacterID","0"];	
	_characterIDNum	= parseNumber (IDC_cargo_towed getVariable ["CharacterID","0"]);	
	
	if (IDC_cargo_towed isKindOf "LandVehicle" || IDC_cargo_towed isKindOf "Air" || IDC_cargo_towed isKindOf "Ship") then {
		if (_objectID > 0) then {
			if (_characterIDNum > 0) then {

				//"Sign_arrow_down_large_EP1"
				_object = createVehicle [_classname, _posplr, [], 0, "CAN_COLLIDE"];	

				_object setVariable ["Sarge",1,true];	
				_object setDir _dirplr;
				_object setPos [_posplr select 0, _posplr select 1, _posplr select 2];
				player reveal _object;
				
				clearWeaponCargoGlobal  _object;
				clearMagazineCargoGlobal  _object;				

				if((_characterIDNum > 0) and (_characterIDNum < 2501)) then {
					_keySelected = Format["ItemKeyGreen%1",_characterIDNum];
				} else {
					if((_characterIDNum > 2500) and (_characterIDNum < 5001)) then {
						_keySelected = Format["ItemKeyRed%1",(_characterIDNum - 2500)];		
					} else {
						if((_characterIDNum > 5000) and (_characterIDNum < 7501)) then {
							_keySelected = Format["ItemKeyBlue%1",(_characterIDNum - 5000)];	
						} else {	
							if((_characterIDNum > 7500) and (_characterIDNum < 10001)) then {
								_keySelected = Format["ItemKeyYellow%1",(_characterIDNum - 7500)];
							} else {	
								if((_characterIDNum > 10000) and (_characterIDNum < 12501)) then {
									_keySelected = Format["ItemKeyBlack%1",(_characterIDNum - 10000)];
								};											
							};								
						};							
					};						
				};
				
				dayzPublishVeh2 = [_object,[_dirplr,_posplr],_classname,false,_keySelected];
				publicVariableServer  "dayzPublishVeh2";				

				TitleText [format["Copied Player Owned Vehicle (Perm): %1! (ID %2 / CID %3)", _classname, _objectID, _characterIDNum], "PLAIN DOWN"];		
			
			} else {
				_object = createVehicle [_classname, _posplr, [], 0, "CAN_COLLIDE"];	

				_object setVariable ["Sarge",1,true];	
				_object setDir _dirplr;
				_object setPos [_posplr select 0, _posplr select 1, _posplr select 2];
				player reveal _object;
				
				clearWeaponCargoGlobal  _object;
				clearMagazineCargoGlobal  _object;				

				dayzPublishVeh = [_object,[_dirplr,_posplr],_classname,true,"0"];
				publicVariableServer  "dayzPublishVeh";

				TitleText [format["Copied Regular Vehicle (Perm): %1! (ID %2 / CID %3)", _classname, _objectID, _characterIDNum], "PLAIN DOWN"];			
			};
		} else {
			_object = _classname createVehicle (_posplr);		
			_object setVariable ["Sarge",1,true];	
			_object setDir _dirplr;
			_object setPos [_posplr select 0, _posplr select 1, _posplr select 2];

			TitleText [format["Copied Temporary Vehicle: %1! (ID %2 / CID %3)", _classname, _objectID, _characterIDNum], "PLAIN DOWN"];
		};	
	} else {

		_object = createVehicle [_classname, _posplr, [], 0, "CAN_COLLIDE"];	

		_object setVariable ["Sarge",1,true];	
		_object setDir _dirplr;
		_object setPos [_posplr select 0, _posplr select 1, _posplr select 2];
		player reveal _object;

		if (_classname == "VaultStorageLocked" || _classname == "VaultStorage") then {	
			_object setVariable ["OEMPos",_posplr,true];
			_object setVariable ["characterID",_characterID,true];
		};		

		if (_classname == "VaultStorageLocked" || _classname == "VaultStorage") then {
		
			dayzPublishVeh = [_object,[_dirplr,_posplr],"VaultStorageLocked",false,_characterID];
			publicVariableServer  "dayzPublishVeh";		

			TitleText [format["Copied Safe (Perm) %1! (ID %2 / CID %3)", _classname, _objectID, _characterIDNum], "PLAIN DOWN"];			
		} else {
			if (_classname in dayz_allowedObjects) then {
				_object setVariable ["characterID",dayz_characterID,true];		

				dayzPublishVeh = [_object,[_dirplr,_posplr],_classname,false,dayz_characterID];
				publicVariableServer  "dayzPublishVeh";					

				TitleText [format["Copied Object (Perm) %1! (ID %2 / CID %3)", _classname, _objectID, _characterIDNum], "PLAIN DOWN"];		
			} else {
				TitleText [format["Copied Temporary Object: %1! (ID %2 / CID %3)", _classname, _objectID, _characterIDNum], "PLAIN DOWN"];			
			};
		};

	};
} else {
	TitleText ["No Object Currently Picked Up, Skipping!", "PLAIN DOWN"];
};
