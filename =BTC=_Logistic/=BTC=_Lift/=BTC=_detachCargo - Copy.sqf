/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
private ["_cargo","_chopper","_cargo_location","_name_cargo","_obj_fall"];

BTC_lifted = 0;
_chopper   = vehicle player;
_cargo     = (nearestObjects [_chopper, BTC_Liftable, 50]) select 1;
_chopper removeAction BTC_SganciaActionId;

detach _cargo;
sleep 0.3;

_cargo_location = _cargo modelToWorld [0,0,0];
if ((_cargo_location select 2) <= 10) then {
	_cargo_location set [2,0];
};
player reveal _cargo;	
sleep 0.3;
_cargo setPos [_cargo_location select 0, _cargo_location select 1, _cargo_location select 2];		
player reveal _cargo;		

_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
vehicle player vehicleChat format ["%1 dropped", _name_cargo];
if (_cargo isKindOf "ReammoBox" || _cargo isKindOf "Static" || _cargo isKindOf "StaticWeapon" || _cargo isKindOf "Strategic" || _cargo isKindOf "Land_HBarrier_large") then {_obj_fall = [_cargo] spawn BTC_Obj_Fall;};
if (true) exitWith {}; 