/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
//tow
BTC_tow_driver   = [];
BTC_tow         = 1;
BTC_towed       = 0;
BTC_tow_min_h   = -10;
BTC_tow_max_h   = 5;
BTC_tow_radius  = 8;
BTC_cargo_towed = objNull;
BTC_towable      = ["M2StaticMG","Fort_Nest_M240","LandVehicle","car","Air","Ship","Motorcycle","Helicopter","Chopper"];
BTC_Hud_Cond     = false;
BTC_HUD_x        = (SafeZoneW+2*SafeZoneX) + 0.045;
BTC_HUD_y        = (SafeZoneH+2*SafeZoneY) + 0.045;
_tow = [] execVM "=BTC=_LogisticTow\=BTC=_tow\=BTC=_towInit.sqf";

//Functions
BTC_get_towable_array =
{
   _LandVehicle = _this select 0;
   _array   = [];
   _all = ["M2StaticMG","Fort_Nest_M240","LandVehicle","car","Air","Ship","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34"];
   switch (typeOf _LandVehicle) do
   {
     //F35 Air
     case "F35B"    : {_array = _all};
     //Cargo Trucks
     case "V3S_Civ"    : {_array = _all};
     case "Kamaz"    : {_array = _all};     
     case "UralCivil"    : {_array = _all};
     case "UralCivil2"    : {_array = _all};
     case "V3S_Open_TK_CIV_EP1"    : {_array = _all};
     case "V3S_Open_TK_EP1"    : {_array = _all};
     case "Ural_CDF"    : {_array = _all};
     case "Ural_TK_CIV_EP1"    : {_array = _all};
     case "Ural_UN_EP1"    : {_array = _all};
     case "MTVR_DES_EP1"    : {_array = _all};
     case "MTVR"   : {_array = _all};
     //Refuel
     case "UralRefuel_INS"    : {_array = _all};
     case "UralRefuel_TK_EP1_DZ"    : {_array = _all};
     case "V3S_Refuel_TK_GUE_EP1_DZ"    : {_array = _all};
     case "MtvrRefuel_DES_EP1_DZ"    : {_array = _all};
     case "KamazRefuel_DZ"    : {_array = _all};     
     //Motorcycle
     case "M1030_US_DES_EP1"    : {_array = _all};
     // Ikarus Bus Variants
     case "Ikarus"  : {_array = _all};
     case "Ikarus_TK_CIV_EP1"    : {_array = _all};
     //Military Armed
     case "ArmoredSUV_PMC_DZE"  : {_array = _all};
     case "ArmoredSUV_PMC_DZ"    : {_array = _all};
     case "BTR60_TK_EP1"    : {_array = _all};
     case "GAZ_Vodnik_DZE"    : {_array = _all};
     case "HMMWV_M1151_M2_CZ_DES_EP1_DZE"    : {_array = _all};
     case "HMMWV_M998A2_SOV_DES_EP1"    : {_array = _all};
     case "HMMWV_M998A2_SOV_DES_EP1_DZE"    : {_array = _all};     
     case "HMMWV_Avenger_DES_EP1"    : {_array = _all};
     case "LandRover_MG_TK_EP1_DZE"     : {_array = _all};
     case "LandRover_Special_CZ_EP1_DZE"    : {_array = _all};
     case "UAZ_MG_TK_EP1_DZE"   : {_array = _all};
     //Military Unarmed
     case "HMMWV_DZ"    : {_array = _all};   
     case "HMMWV_M1035_DES_EP1"    : {_array = _all};     
     case "HMMWV_M998_crows_MK19_DES_EP1"    : {_array = _all};
     case "HMMWV_MK19_DES_EP1"    : {_array = _all};
     case "HMMWV_Ambulance_CZ_DES_EP1"  : {_array = _all};
     case "HMMWV_Ambulance"  : {_array = _all};
     case "HMMWV_DES_EP1"  : {_array = _all};
     case "GAZ_Vodnik_MedEvac"    : {_array = _all};
     case "GAZ_Vodnik_HMG"    : {_array = _all};
     case "LandRover_CZ_EP1"    : {_array = _all};
     case "LandRover_TK_CZ_EP1"    : {_array = _all};
     //Misc.
     case "Tractor"    : {_array = _all};
     case "TowingTractor"   : {_array = _all};
     case "Ural_INS"    : {_array = _all};
	 };
   _array
};
BTC_obj_fall =
{
	private ["_cargo_location","_obj","_height","_retrycounter","_fall","_final_location"];

   _obj    = _this select 0;
   _height = getPos _obj select 2;

	_cargo_location = _obj modelToWorld [0,0,0];
	_retrycounter = 0;
	while {(((abs(_cargo_location select 0) == 0) || (abs(_cargo_location select 0) == 1)) && ((abs(_cargo_location select 1) == 0) || (abs(_cargo_location select 1) == 1))) && (!(_retrycounter > 20))} do {
		sleep 0.1;
		_cargo_location = _obj modelToWorld [0,0,0];
		sleep 0.1;
		_retrycounter = _retrycounter + 1;	
	};	
	_cargo_location	set [2, 0];

	_retrycounter = 0;	
   _fall   = 0.09;
   while {(((getPos _obj select 2) > 1) || (((abs(getPos _obj select 0) == 0) || (abs(getPos _obj select 0) == 1)) && ((abs(getPos _obj select 1) == 0) || (abs(getPos _obj select 1) == 1)))) && (!(_retrycounter > 20))} do 
   {
		if (_height > 0) then {
			_fall = (_fall * 1.1);
			_obj setPosATL [_cargo_location select 0, _cargo_location select 1, _height];
			_height = _height - _fall;
		};
		sleep 0.01;
		_retrycounter = _retrycounter + 1;			
   };
	_obj setPosATL [_cargo_location select 0, _cargo_location select 1, 0];

	sleep 0.1;
	_final_location = getPosATL _obj;
	_retrycounter = 0;
	while {(((abs(_final_location select 0) == 0) || (abs(_final_location select 0) == 1)) && ((abs(_final_location select 1) == 0) || (abs(_final_location select 1) == 1)) && ((abs(_final_location select 2) == 0) || (abs(_final_location select 2) == 1))) && (!(_retrycounter > 20))} do {
		_obj setPosATL [_cargo_location select 0, _cargo_location select 1, 0];
		sleep 0.1;
		_final_location = getPosATL _obj;
		_retrycounter = _retrycounter + 1;		
	};   
   
};
BTC_paradrop =
{
   _Veh          = _this select 0;
   _dropped      = _this select 1;
   _chute_type   = _this select 2;
   private ["_chute"];
   _dropped_type = typeOf _dropped;
   if (typeOf _Veh == "MH6J_EP1") then {_chute = createVehicle [_chute_type, [((position _Veh) select 0) - 5,((position _Veh) select 1) - 10,((position _Veh) select 2)- 4], [], 0, "NONE"];} else {_chute = createVehicle [_chute_type, [((position _Veh) select 0) - 5,((position _Veh) select 1) - 3,((position _Veh) select 2)- 4], [], 0, "NONE"];};
   _smoke        = "SmokeshellGreen" createVehicle position _Veh;
    _smoke attachto [_dropped,[0,0,0]]; 
   _dropped attachTo [_chute,[0,0,0]];
   while {getPos _chute select 2 > 2} do {sleep 1;};
   detach _dropped;
};
BTC_hint = {_text  = _this select 0;_sleep = _this select 1;hintSilent _text;sleep _sleep;hintSilent "";};