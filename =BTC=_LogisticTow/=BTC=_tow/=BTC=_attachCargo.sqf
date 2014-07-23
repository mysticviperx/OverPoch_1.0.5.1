/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
_LandVehicle = vehicle player;
_LandVehicle removeAction BTC_towActionId;
BTC_towed    = 1;
BTC_dropcargo = 0;
_cargo_pos    = getPosATL BTC_cargo_towed;
_rel_pos      = _LandVehicle worldToModel _cargo_pos;
_height       = (_rel_pos select 2) + 2.5;
BTC_cargo_towed attachTo [_LandVehicle, [0,-12,.15]];

if (!isNil {BTC_cargo_towed getVariable "IDCTowedBy"}) then {
	_curr_IDCTowedBy = BTC_cargo_towed getVariable "IDCTowedBy";

	if (!isNil {_curr_IDCTowedBy getVariable "IDCTowing"}) then {
		_curr_IDCTowing = _curr_IDCTowedBy getVariable "IDCTowing";
		
		if ((_curr_IDCTowing == BTC_cargo_towed) && (_LandVehicle != _curr_IDCTowedBy)) then {
			_curr_IDCTowedBy setVariable ["IDCTowing",nil,true];

/* 			_minutes = floor (time / 60);
			_seconds = floor (time - (_minutes * 60));
			diag_log ((str _minutes + ":" + str _seconds) + " Debug: " + "Reset IDCTowing of Old Tower (from attachCargo) - Tower: " + (typeOf _LandVehicle) + " Towee: " + (typeOf BTC_cargo_towed));	
	 		titleText [format["Reset IDCTowing of Old Tower (from attachCargo) - Tower: %1 Towee: %2",(typeOf _LandVehicle),(typeOf BTC_cargo_towed)], "PLAIN"];
*/			

			//_curr_IDCTowedBy setVariable ["IDCDropActionID",nil,true];
		};
	};
};

BTC_cargo_towed setVariable ["IDCTowedBy",_LandVehicle,true];
_LandVehicle setVariable ["IDCTowing",BTC_cargo_towed,true];


_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_towed >> "displayName");
vehicle player vehicleChat format ["%1 towed", _name_cargo];
_text_action = ("<t color=""#ED2744"">" + "Drop " + (_name_cargo) + "</t>");
//BTC_SganciaActionId = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_detachCargo.sqf", "", 7, false, false];


_IDCDropActionID = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_detachCargo.sqf", "", 7, false, false];
_LandVehicle setVariable ["IDCDropActionID",_IDCDropActionID,true];
if (!(_LandVehicle in haveIDCDropActionLocal)) then {
	haveIDCDropActionLocal = haveIDCDropActionLocal + [_LandVehicle];
	haveIDCDropActionIDLocal = haveIDCDropActionIDLocal + [[_LandVehicle,_IDCDropActionID]];	
};

if (true) exitWith {}; 