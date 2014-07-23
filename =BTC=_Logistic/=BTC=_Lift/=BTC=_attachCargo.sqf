/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
_chopper = vehicle player;
_chopper removeAction BTC_liftActionId;
BTC_lifted    = 1;
BTC_dropcargo = 0;
_cargo_pos    = getPosATL BTC_cargo_lifted;
_rel_pos      = _chopper worldToModel _cargo_pos;
_height       = (_rel_pos select 2) + 2.5;
BTC_cargo_lifted attachTo [_chopper, [0,0,_height]];

if (!isNil {BTC_cargo_lifted getVariable "IDCTowedBy"}) then {
	_curr_IDCTowedBy = BTC_cargo_lifted getVariable "IDCTowedBy";

	if (!isNil {_curr_IDCTowedBy getVariable "IDCTowing"}) then {
		_curr_IDCTowing = _curr_IDCTowedBy getVariable "IDCTowing";
		
		if ((_curr_IDCTowing == BTC_cargo_lifted) && (_chopper != _curr_IDCTowedBy)) then {
			_curr_IDCTowedBy setVariable ["IDCTowing",nil,true];

/* 			_minutes = floor (time / 60);
			_seconds = floor (time - (_minutes * 60));
			diag_log ((str _minutes + ":" + str _seconds) + " Debug: " + "Reset IDCTowing of Old Lifter (from attachCargo) - Lifter: " + (typeOf _chopper) + " Liftee: " + (typeOf BTC_cargo_lifted));	
	 		titleText [format["Reset IDCTowing of Old Lifter (from attachCargo) - Lifter: %1 Liftee: %2",(typeOf _chopper),(typeOf BTC_cargo_lifted)], "PLAIN"];
*/			

			//_curr_IDCTowedBy setVariable ["IDCDropActionID",nil,true];
		};
	};
};

BTC_cargo_lifted setVariable ["IDCTowedBy",_chopper,true];
_chopper setVariable ["IDCTowing",BTC_cargo_lifted,true];



_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_lifted >> "displayName");
vehicle player vehicleChat format ["%1 lifted", _name_cargo];
_text_action = ("<t color=""#ED2744"">" + "Drop " + (_name_cargo) + "</t>");
//BTC_SganciaActionId = _chopper addAction [_text_action,"=BTC=_Logistic\=BTC=_Lift\=BTC=_detachCargo.sqf", "", 7, false, false];


_IDCDropActionID = _chopper addAction [_text_action,"=BTC=_Logistic\=BTC=_Lift\=BTC=_detachCargo.sqf", "", 7, false, false];
_chopper setVariable ["IDCDropActionID",_IDCDropActionID,true];
if (!(_chopper in haveIDCDropActionLocal)) then {
	haveIDCDropActionLocal = haveIDCDropActionLocal + [_chopper];
	haveIDCDropActionIDLocal = haveIDCDropActionIDLocal + [[_chopper,_IDCDropActionID]];	
};



if (true) exitWith {}; 