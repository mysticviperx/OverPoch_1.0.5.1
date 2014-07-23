/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
private ["_cargo","_chopper","_cargo_location","_name_cargo","_obj_fall","_lifting_veh_pos","_liftradius","_final_location","_flagaddedallowed","_classname","_objectIDNum","_IDCDropActionID"];

BTC_lifted = 0;
_chopper   = vehicle player;

//_cargo     = (nearestObjects [_chopper, BTC_Liftable, 50]) select 1;
_cargo = BTC_cargo_lifted;

//_chopper removeAction BTC_SganciaActionId;

_lifting_veh_pos = _chopper modelToWorld [0,0,0];
_liftradius = BTC_lift_radius + 5;
_dir = getDir _cargo;

detach _cargo;

_IDCDropActionID = _chopper getVariable "IDCDropActionID";
haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_chopper,_IDCDropActionID]];
_chopper removeAction _IDCDropActionID;
_chopper setVariable ["IDCDropActionID",nil,true];

_cargo setVariable ["IDCTowedBy",nil,true];
_chopper setVariable ["IDCTowing",nil,true];

if (_chopper in haveIDCDropActionLocal) then {
	{
		if ((_x select 0 == _chopper)) then {
			_tempobj = _x select 0;
			_tempaction = _x select 1;			
			_tempobj removeAction _tempaction;
			haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_chopper,_tempaction]];				
		};
	} forEach haveIDCDropActionIDLocal;
	haveIDCDropActionLocal = haveIDCDropActionLocal - [_chopper];
};


BTC_cargo_lifted = objNull;

player reveal _cargo;	

_cargo_location = _cargo modelToWorld [0,0,0];
if ((_cargo_location select 2) <= 10) then {
	if (speed _cargo <= 25) then {
		_cargo setVelocity [0,0,0];
	};
	_cargo_location set [2,0];

	_retrycounter = 0;
	while {((abs ((_cargo_location select 0) - (_lifting_veh_pos select 0)) > _liftradius) || (abs ((_cargo_location select 1) - (_lifting_veh_pos select 1)) > _liftradius) || (((abs(_cargo_location select 0) == 0) || (abs(_cargo_location select 0) == 1)) && ((abs(_cargo_location select 1) == 0) || (abs(_cargo_location select 1) == 1)) && ((abs(_cargo_location select 2) == 0) || (abs(_cargo_location select 2) == 1)))) && (!(_retrycounter > 20))} do {
		sleep 0.1;

		_cargo_location = _cargo modelToWorld [0,0,0];
		if ((_cargo_location select 2) <= 10) then {
			_cargo_location set [2,0];
		};
		sleep 0.1;
		_retrycounter = _retrycounter + 1;	
	};
	/*
	if (_retrycounter > 20) then {
		TitleText ["First Retry Counter Got Over 20", "PLAIN DOWN"];
		sleep 10;	
	};
	*/

	//TitleText ["Got To Next Part", "PLAIN DOWN"];
	sleep 0.1;

	if (_cargo_location select 2 == 0) then {
		_cargo setDir _dir;		
		_cargo setPos [_cargo_location select 0, _cargo_location select 1, 0];
		sleep 0.1;
		_final_location = getPos _cargo;
		_retrycounter = 0;
		while {((abs ((_final_location select 0) - (_cargo_location select 0)) > 2) || (abs ((_final_location select 1) - (_cargo_location select 1)) > 2) || (abs ((_final_location select 2) - (_cargo_location select 2)) > 2) || (((abs(_final_location select 0) == 0) || (abs(_final_location select 0) == 1)) && ((abs(_final_location select 1) == 0) || (abs(_final_location select 1) == 1)) && ((abs(_final_location select 2) == 0) || (abs(_final_location select 2) == 1))))  && (!(_retrycounter > 20))} do {
			_cargo setDir _dir;		
			_cargo setPos [_cargo_location select 0, _cargo_location select 1, 0];
			sleep 0.1;
			_final_location = getPos _cargo;
			_retrycounter = _retrycounter + 1;		
		};
	};
	/*
	if (_retrycounter > 20) then {
		TitleText ["Second Retry Counter Got Over 20", "PLAIN DOWN"];	
		sleep 10;
	};
	*/

	sleep 0.1;
	player reveal _cargo;

};



_objectIDNum = parseNumber (_cargo getVariable ["ObjectID","0"]);
if (_objectIDNum > 0 && (!(_cargo isKindOf "ReammoBox" || _cargo isKindOf "Static" || _cargo isKindOf "StaticWeapon" || _cargo isKindOf "Strategic" || _cargo isKindOf "Land_HBarrier_large"))) then {
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
_final_location = getPosATL _cargo;

TitleText [format["Vehicle At: %1, %2, %3 / Supposed To Be At: %4, %5, %6", _final_location select 0, _final_location select 1, _final_location select 2, _cargo_location select 0, _cargo_location select 1, _cargo_location select 2], "PLAIN DOWN"];	
*/

/*
sleep 0.3;
_cargo_location = _cargo modelToWorld [0,0,0];
if ((_cargo_location select 2) <= 10) then {
	_cargo_location set [2,0];
};
player reveal _cargo;	
sleep 0.3;
_cargo setPos [_cargo_location select 0, _cargo_location select 1, _cargo_location select 2];		
player reveal _cargo;		
*/


_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
vehicle player vehicleChat format ["%1 dropped", _name_cargo];
if (_cargo isKindOf "ReammoBox" || _cargo isKindOf "Static" || _cargo isKindOf "StaticWeapon" || _cargo isKindOf "Strategic" || _cargo isKindOf "Land_HBarrier_large") then {_obj_fall = [_cargo] spawn BTC_Obj_Fall;};
if (true) exitWith {}; 