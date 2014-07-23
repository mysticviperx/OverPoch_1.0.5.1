/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
private ["_veh_tempcounter","_LandVehicle","_cargo_test","_cargo","_cargo_location","_final_location","_dir","_towing_veh_pos","_retrycounter","_towradius","_flagaddedallowed","_classname","_objectIDNum","_IDCDropActionID"];

_veh_tempcounter = 0;
BTC_towed = 0;
_LandVehicle   = vehicle player;

/*
_cargo_test     = (nearestObjects [_LandVehicle, BTC_towable, 50]);
{
	_veh_tempcounter = _veh_tempcounter + 1;
	if (_veh_tempcounter > 1) then {
		if (getDir _x == getDir _LandVehicle) then {
			_cargo = _x;
		};
	};
} forEach _cargo_test;
*/
_cargo = BTC_cargo_towed;


_towradius = BTC_tow_radius + 10;
//_LandVehicle removeAction BTC_SganciaActionId;
//BTC_SganciaActionId = -1;


_towing_veh_pos = _LandVehicle modelToWorld [0,0,0];
_towing_veh_pos set [2,0];

_dir = getDir _cargo;
detach _cargo;


_IDCDropActionID = _LandVehicle getVariable "IDCDropActionID";
haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_LandVehicle,_IDCDropActionID]];
_LandVehicle removeAction _IDCDropActionID;
_LandVehicle setVariable ["IDCDropActionID",nil,true];

_cargo setVariable ["IDCTowedBy",nil,true];
_LandVehicle setVariable ["IDCTowing",nil,true];

if (_LandVehicle in haveIDCDropActionLocal) then {
	{
		if ((_x select 0 == _LandVehicle)) then {
			_tempobj = _x select 0;
			_tempaction = _x select 1;			
			_tempobj removeAction _tempaction;
			haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_LandVehicle,_tempaction]];				
		};
	} forEach haveIDCDropActionIDLocal;
	haveIDCDropActionLocal = haveIDCDropActionLocal - [_LandVehicle];
};

if (speed _cargo <= 25) then {
	_cargo setVelocity [0,0,0];
};
BTC_cargo_towed = objNull;

player reveal _cargo;	

_cargo_location = _cargo modelToWorld [0,0,0];
_cargo_location set [2,0];
  

_retrycounter = 0;
while {((abs ((_cargo_location select 0) - (_towing_veh_pos select 0)) > _towradius) || (abs ((_cargo_location select 1) - (_towing_veh_pos select 1)) > _towradius) || (abs ((_cargo_location select 2) - (_towing_veh_pos select 2)) > 11) || (((abs(_cargo_location select 0) == 0) || (abs(_cargo_location select 0) == 1)) && ((abs(_cargo_location select 1) == 0) || (abs(_cargo_location select 1) == 1)))) && (!(_retrycounter > 20))} do {
	sleep 0.1;
	_cargo_location = _cargo modelToWorld [0,0,0];
	_cargo_location set [2,0];	
	sleep 0.1;
	_retrycounter = _retrycounter + 1;	
};
/*
if (_retrycounter > 20) then {
	TitleText ["First Retry Counter Got Over 20", "PLAIN DOWN"];
	sleep 10;	
};
*/

/*
TitleText ["Got To Next Part", "PLAIN DOWN"];
*/
sleep 0.1;


_cargo setDir _dir;		
_cargo setPos [_cargo_location select 0, _cargo_location select 1, 0];
sleep 0.1;

_final_location = getPos _cargo;
_retrycounter = 0;
while {((abs ((_final_location select 0) - (_cargo_location select 0)) > 3) || (abs ((_final_location select 1) - (_cargo_location select 1)) > 3) || (((abs(_final_location select 0) == 0) || (abs(_final_location select 0) == 1)) && ((abs(_final_location select 1) == 0) || (abs(_final_location select 1) == 1))))  && (!(_retrycounter > 40))} do {
	_cargo setDir _dir;		
	_cargo setPos [_cargo_location select 0, _cargo_location select 1, 0];
	sleep 0.1;
	_final_location = getPos _cargo;
	_retrycounter = _retrycounter + 1;		
};
/*
if (_retrycounter > 40) then {
	TitleText ["Second Retry Counter Got Over 40", "PLAIN DOWN"];	
	sleep 10;
};
*/
sleep 0.1;

player reveal _cargo;

_objectIDNum = parseNumber (_cargo getVariable ["ObjectID","0"]);
if (_objectIDNum > 0) then {
	_classname = (typeOf _cargo);
	// Add to allowed update objects
	_flagaddedallowed = false;
	if (!(_classname in dayz_updateObjects) && _objectIDNum > 0) then {
		_flagaddedallowed = true;
		dayz_updateObjects	= dayz_updateObjects + [_classname];
	};

	dayzUpdateVehicle = [_cargo, "positionnow-atl"];
	publicVariableServer "dayzUpdateVehicle";	
	
	// Remove from allowed update objects
	if (_flagaddedallowed) then {
		_flagaddedallowed = false;
		dayz_updateObjects	= dayz_updateObjects - [_classname];
	};	
};

/*
sleep 1;
_final_location = getPos _cargo;

TitleText [format["Vehicle At: %1, %2, %3 / Supposed To Be At: %4, %5, %6", _final_location select 0, _final_location select 1, _final_location select 2, _cargo_location select 0, _cargo_location select 1, _cargo_location select 2], "PLAIN DOWN"];	
*/

_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
vehicle player vehicleChat format ["%1 dropped", _name_cargo];
//if (_cargo isKindOf "ReammoBox" || _cargo isKindOf "Static" || _cargo isKindOf "StaticWeapon" || _cargo isKindOf "Strategic" || _cargo isKindOf "Land_HBarrier_large") then {_obj_fall = [_cargo] spawn BTC_Obj_Fall;};
if (true) exitWith {}; 