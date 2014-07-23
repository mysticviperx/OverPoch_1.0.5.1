/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/

private ["_ownerID","_convertownerID","_haskey","_tempKeyName","_alreadytowingobj","_alreadytowedobj","_can_tow","_IDCDropActionID"];

if (isDedicated) exitwith {};
_cond = true;
if ((count BTC_tow_driver) > 0) then 
{
	if ((BTC_tow_driver find (typeof player)) == - 1) exitWith {hint "No tow";_cond = false;};
};
if !(_cond) exitWith {hint "No tow";};
disableSerialization;
_cargo = objNull;
haveIDCDropActionLocal = [];
haveIDCDropActionIDLocal = [];
BTC_Hud_Shown = false;
cutRsc ["BTC_Hud","PLAIN DOWN"];
_ui        = uiNamespace getVariable "HUD";
_radar     = _ui displayCtrl 1001;
_obj_img   = _ui displayCtrl 1002;
_obj_pic   = _ui displayCtrl 1003;
_arrow     = _ui displayCtrl 1004;
_obj_name  = _ui displayCtrl 1005;
_array_hud = [_radar,_obj_img,_obj_pic,_arrow,_obj_name];
{_x ctrlShow false} foreach _array_hud;
_LandVehicle = objNull;_cargo_pos = [];_rel_pos = [];_cargo_x = 0;_cargo_y = 0;_cargo_z = 0;
while {true} do 
{
	if (!Alive player) then {{_x ctrlShow false} foreach _array_hud;};
	if (BTC_Hud_Cond) then {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Cond = false;};
	waitUntil {sleep 1; (vehicle player != player && vehicle player iskindof "LandVehicle" && ((count([vehicle player] call BTC_Get_towable_array)) > 0))};
	if (!(vehicle player == player) && driver vehicle player == player) then {_LandVehicle = vehicle player;BTC_towHudId = _LandVehicle addAction [("<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"),"=BTC=_LogisticTow\=BTC=_tow\=BTC=_Hud.sqf", "", 0, false, false];};
	_array = [vehicle player] call BTC_get_towable_array;
	while {!(vehicle player == player) && driver vehicle player == player} do
	{
		_LandVehicle  = vehicle player;
		_can_tow = false;
		_cargo_array = nearestObjects [_LandVehicle, BTC_towable, 50];
		if (count _cargo_array > 1) then {_cargo = _cargo_array select 1;} else {_cargo = objNull;};
		

		if (!isNil {_LandVehicle getVariable "IDCTowing"}) then {
			_alreadytowingobj = _LandVehicle getVariable "IDCTowing";
			if (!isNil {_alreadytowingobj getVariable "IDCTowedBy"}) then {	
				_alreadytowedobj = _alreadytowingobj getVariable "IDCTowedBy";
				if (_LandVehicle == _alreadytowedobj) then {

//						cutText ["Towing match!","PLAIN DOWN",2];

					BTC_cargo_towed = _alreadytowingobj;
					if (isNil {_LandVehicle getVariable "IDCDropActionID"}) then {
						_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_towed >> "displayName");	
/* 
						_minutes = floor (time / 60);
						_seconds = floor (time - (_minutes * 60));
						diag_log ((str _minutes + ":" + str _seconds) + " Debug: " + "Added addAction via towInit Part 1 - Tower: " + (typeOf _LandVehicle) + " Towee: " + (_name_cargo));							
						titleText [format["Added addAction via towInit Part 1 - Tower: %1 Towee: %2",(typeOf _LandVehicle),(_name_cargo)], "PLAIN"];
*/							
						_text_action = ("<t color=""#ED2744"">" + "Drop " + (_name_cargo) + "</t>");
						_IDCDropActionID = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_detachCargo.sqf", "", 7, false, false];
						_LandVehicle setVariable ["IDCDropActionID",_IDCDropActionID,true];
						if (!(_LandVehicle in haveIDCDropActionLocal)) then {
							haveIDCDropActionLocal = haveIDCDropActionLocal + [_LandVehicle];
							haveIDCDropActionIDLocal = haveIDCDropActionIDLocal + [[_LandVehicle,_IDCDropActionID]];								
						};
					} else {
						if (!(_LandVehicle in haveIDCDropActionLocal)) then {
							_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_towed >> "displayName");	
/* 
							_minutes = floor (time / 60);
							_seconds = floor (time - (_minutes * 60));
							diag_log ((str _minutes + ":" + str _seconds) + " Debug: " + "Added addAction via towInit Part 2 - Tower: " + (typeOf _LandVehicle) + " Towee: " + (_name_cargo));
							titleText [format["Added addAction via towInit Part 2 - Tower: %1 Towee: %2",(typeOf _LandVehicle),(_name_cargo)], "PLAIN"];
*/							
							_text_action = ("<t color=""#ED2744"">" + "Drop " + (_name_cargo) + "</t>");
							_IDCDropActionID = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_detachCargo.sqf", "", 7, false, false];
							_LandVehicle setVariable ["IDCDropActionID",_IDCDropActionID,true];
							haveIDCDropActionLocal = haveIDCDropActionLocal + [_LandVehicle];
							haveIDCDropActionIDLocal = haveIDCDropActionIDLocal + [[_LandVehicle,_IDCDropActionID]];									
						};
					};
					BTC_towed = 1;
					_can_tow = false;
				} else {
				
//						cutText [format["Towing mis-match - Tower: %1 - Towee: %2",typeOf _LandVehicle, typeOf _alreadytowedobj],"PLAIN DOWN",2];
					BTC_cargo_towed = objNull;	

					if (!isNil {_LandVehicle getVariable "IDCDropActionID"}) then {
						_IDCDropActionID = _LandVehicle getVariable "IDCDropActionID";
						haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_LandVehicle,_IDCDropActionID]];							
						_LandVehicle removeAction _IDCDropActionID;

						_LandVehicle setVariable ["IDCDropActionID",nil,true];
						_LandVehicle setVariable ["IDCTowing",nil,true];						

/* 							
						_minutes = floor (time / 60);
						_seconds = floor (time - (_minutes * 60));
						diag_log ((str _minutes + ":" + str _seconds) + " Debug: " + "Removed addAction via towInit Part 1 (Tower/Towee mismatch) - Tower: " + (typeOf _LandVehicle) + " Towee: " + (typeOf _alreadytowingobj));							
						titleText [format["Removed addAction via towInit Part 1 (Tower/Towee mismatch) - Tower: %1 Towee: %2",(typeOf _LandVehicle),(typeOf _alreadytowingobj)], "PLAIN"];							
*/
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
						
					} else {
						_LandVehicle setVariable ["IDCTowing",nil,true];						
					};
					
					//_LandVehicle removeAction BTC_SganciaActionId;
					//BTC_SganciaActionId = -1;
				
					BTC_towed = 0;				
				};
			} else {
				BTC_cargo_towed = objNull;	
				_LandVehicle setVariable ["IDCTowing",nil,true];	
				if (!isNil {_LandVehicle getVariable "IDCDropActionID"}) then {
					_IDCDropActionID = _LandVehicle getVariable "IDCDropActionID";
					haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_LandVehicle,_IDCDropActionID]];							
					_LandVehicle removeAction _IDCDropActionID;
					
					_LandVehicle setVariable ["IDCDropActionID",nil,true];				
				};				
			
//					cutText ["IDCTowedBy is Nil","PLAIN DOWN",2];					
			};
		} else {
			BTC_cargo_towed = objNull;				
			if (!isNil {_LandVehicle getVariable "IDCDropActionID"}) then {
				_IDCDropActionID = _LandVehicle getVariable "IDCDropActionID";
				haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_LandVehicle,_IDCDropActionID]];							
				_LandVehicle removeAction _IDCDropActionID;
	
				_LandVehicle setVariable ["IDCDropActionID",nil,true];				
			};
//				cutText ["IDCTowing is Nil","PLAIN DOWN",2];
		};

		
		
		if (({_cargo isKindOf _x} count _array) > 0) then {_can_tow = true;};
		if (!BTC_Hud_Cond && BTC_Hud_Shown) then {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Shown = false;};
		if ((_cargo isKindOf "StaticWeapon" && getdammage _cargo != 1) && (!(_cargo isKindOf "Fort_Nest_M240")) && (!(_cargo isKindOf "M2StaticMG"))) then {_can_tow = false;};

		//---------------------------------------------------------------------------------------
		// If (_cargo isKindOf "StaticWeapon") then check for driver of _LandVehicle -- If they don't have the key for BTC_cargo_towed then tell them no
		//---------------------------------------------------------------------------------------
		if (_cargo isKindOf "StaticWeapon") then {
			_ownerID = _cargo getVariable ["characterID","0"];
			_convertownerID = 0; 
			_convertownerID = parseNumber _ownerID;						
			if (_convertownerID > 0) then {
				_haskey = false;			
				_tempKeyName = "UNKNOWN";
				if((_convertownerID > 0) and (_convertownerID < 2501)) then {
					_tempKeyName = Format["ItemKeyGreen%1",_convertownerID];
				} else {
					if((_convertownerID > 2500) and (_convertownerID < 5001)) then {
						_tempKeyName = Format["ItemKeyRed%1",(_convertownerID - 2500)];		
					} else {
						if((_convertownerID > 5000) and (_convertownerID < 7501)) then {
							_tempKeyName = Format["ItemKeyBlue%1",(_convertownerID - 5000)];	
						} else {	
							if((_convertownerID > 7500) and (_convertownerID < 10001)) then {
								_tempKeyName = Format["ItemKeyYellow%1",(_convertownerID - 7500)];
							} else {	
								if((_convertownerID > 10000) and (_convertownerID < 12501)) then {
									_tempKeyName = Format["ItemKeyBlack%1",(_convertownerID - 10000)];
								};											
							};								
						};							
					};						
				};				
				if (_tempKeyName == "UNKNOWN") then {
					_haskey = false;
				} else {
					_haskey = _tempKeyName in items player;				
				};
				if (!(_haskey)) then {
					_can_tow = false;				
				};
			};
		};		
		//---------------------------------------------------------------------------------------		

		
		if (!isNull _cargo && _can_tow) then
		{
			_cargo_pos = getPosATL _cargo;
			_rel_pos   = _LandVehicle worldToModel _cargo_pos;
			_cargo_x   = _rel_pos select 0;
			_cargo_y   = _rel_pos select 1;
			_cargo_z   = _rel_pos select 2;
		};
		if (!isNull _cargo && BTC_Hud_Cond) then
		{
			if !(BTC_Hud_Shown) then {{_x ctrlShow true} foreach _array_hud;BTC_Hud_Shown = true;};
			if (_can_tow) then 
			{
				_obj_img ctrlShow true;
				_hud_x   = (_rel_pos select 0) / 100;
				_rel_y   = (_rel_pos select 1);
				_hud_y   = 0;
				switch (true) do
				{
					case (_rel_y < 0): {_hud_y = (abs _rel_y) / 100};
					case (_rel_y > 0): {_hud_y = (0 - _rel_y) / 100};
				};
				_hud_x_1 = BTC_HUD_x + _hud_x;
				_hud_y_1 = BTC_HUD_y + _hud_y;
				_obj_img ctrlsetposition [_hud_x_1, _hud_y_1];
				_obj_img ctrlCommit 0;
			} else {_obj_img ctrlShow false;};
			_pic_cargo = "";
			if (_cargo isKindOf "LandVehicle") then {_pic_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "picture");} else {_pic_cargo = "";};
			_name_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
			_obj_pic ctrlSetText _pic_cargo;
			_obj_name ctrlSetText _name_cargo;
			if ((abs _cargo_z) > BTC_tow_max_h) then {_arrow ctrlSetText "\ca\ui\data\arrow_down_ca.paa";};
			if ((abs _cargo_z) < BTC_tow_min_h) then {_arrow ctrlSetText "\ca\ui\data\arrow_up_ca.paa";};
			if ((abs _cargo_z) > BTC_tow_min_h && (abs _cargo_z) < BTC_tow_max_h) then {_arrow ctrlSetText "\ca\ui\data\objective_complete_ca.paa";};
			if (!_can_tow && BTC_Hud_Cond) then {_arrow ctrlSetText "\ca\ui\data\objective_incomplete_ca.paa";};
		} else {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Shown = false;};		
		if (!isNull _cargo && (isNil {_LandVehicle getVariable "IDCTowing"}) && _can_tow && format ["%1", _cargo getVariable "BTC_Cannot_tow"] != "1") then 
		{
			if (((abs _cargo_z) < BTC_tow_max_h) && ((abs _cargo_z) > BTC_tow_min_h) && ((abs _cargo_x) < BTC_tow_radius) && ((abs _cargo_y) < BTC_tow_radius)) then
			{
				BTC_cargo_towed = _cargo;
				_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
				_text_action = ("<t color=""#ED2744"">" + "Tow " + (_name_cargo) + "</t>");
				if (!isNil {_LandVehicle getVariable "IDCTowing"}) then {_LandVehicle removeAction BTC_towActionId;};
				if ((isNil {_LandVehicle getVariable "IDCTowing"}) && BTC_tow == 1) then
				{
					BTC_towActionId = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_attachCargo.sqf", "", 7, true, true];
					BTC_tow = 0;
				};
			};
			if (BTC_tow == 0 && (((abs _cargo_z) > BTC_tow_max_h) || ((abs _cargo_z) < BTC_tow_min_h) || ((abs _cargo_x) > BTC_tow_radius) || ((abs _cargo_y) > BTC_tow_radius))) then 
			{
				_LandVehicle removeAction BTC_towActionId;
				BTC_tow = 1;
			};
		};
		sleep 0.1;
	};
	_IDCDropActionID = _LandVehicle getVariable "IDCDropActionID";
	haveIDCDropActionLocal = haveIDCDropActionLocal - [_LandVehicle];	
	haveIDCDropActionIDLocal = haveIDCDropActionIDLocal - [[_LandVehicle,_IDCDropActionID]];							
	_LandVehicle removeAction _IDCDropActionID;	
	
	_LandVehicle removeAction BTC_towHudId;
	if (BTC_tow == 0) then {_LandVehicle removeAction BTC_towActionId;BTC_tow = 1;};
};

if (true) exitWith {}; 