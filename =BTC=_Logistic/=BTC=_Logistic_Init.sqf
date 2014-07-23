/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
//Lift
BTC_lift_pilot   = [];
BTC_lift         = 1;
BTC_lifted       = 0;
BTC_lift_min_h   = 7;
BTC_lift_max_h   = 15;
BTC_lift_radius  = 10;
BTC_cargo_lifted = objNull;
BTC_Liftable     = ["M2StaticMG","Fort_Nest_M240","LandVehicle","Air","Land_HBarrier_large","Boat","Chopper","Helicopter"];
BTC_Hud_Cond     = false;
BTC_HUD_x        = (SafeZoneW+2*SafeZoneX) + 0.045;
BTC_HUD_y        = (SafeZoneH+2*SafeZoneY) + 0.045;
_lift = [] execVM "=BTC=_Logistic\=BTC=_Lift\=BTC=_LiftInit.sqf";

//Functions
BTC_get_liftable_array =
{
   _chopper = _this select 0;
   _array   = [];
   switch (typeOf _chopper) do
   {
	  //LittleBirds
      case "MH6J_EP1"    : {_array = ["Motorcycle","Fort_Nest_M240","M2StaticMG"];};
	  case "MH6J_DZ"    : {_array = ["Motorcycle","Fort_Nest_M240","M2StaticMG"];};
	  case "AH6J_EP1"    : {_array = ["Motorcycle","Fort_Nest_M240","M2StaticMG"];};	  
	  case "AH6X_DZ"    : {_array = ["Motorcycle","Fort_Nest_M240","M2StaticMG"];};	  
	  //Mi17 Variants
      case "Mi17_Civilian_DZ"      : {_array = ["Motorcycle","Fort_Nest_M240","M2StaticMG"];};
      case "Mi17_DZE"   : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];}; 
      case "Mi17_DZ"     : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};	  
      //KA52
      case "KA52Black"    : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];}; 
	  //Kobra
      case "AH1Z"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	 
	  //Osprey
      case "MV22"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	 
	  case "MV22_DZ"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	 
	  //Huey Variants
	  case "UH1Y_DZE"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	  
	  case "UH1H_DZE"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	  
      //Blackhawk  
      case "UH60M_EP1_DZE"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	  
	  case "UH60M_EP1"      : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};	  
	  //Seahawk
      case "MH60S"       : {_array = ["LandVehicle","car","Boat","Motorcycle","Helicopter","Chopper","AH6X_DZ","UH1H_DZ","AH1Z","MH60S","Fort_Nest_M240","M2StaticMG"];};  
	  //Mi24
      case "Mi24_D"      : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};	  
	  //Chinook Variants
      case "CH_47F_EP1_DZ"      : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};	  
	  case "CH_47F_EP1_DZE"      : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};	  
	  case "CH_47F_EP1"  : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};
      case "CH_47F_BAF"  : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};
      //BAF Merlin
      case "BAF_Merlin_HC3_D"  : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};
      //Kamov Ka-60
      case "Ka60_PMC"  : {_array = ["LandVehicle","car","Air","Boat","Motorcycle","Helicopter","Chopper","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Boat","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34","Fort_Nest_M240","M2StaticMG"];};      
      };
   _array
};
BTC_obj_fall =
{
	private ["_cargo_location","_obj","_height","_retrycounter","_fall","_final_location","_flagaddedallowed","_classname","_objectIDNum"];

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
			_obj setPos [_cargo_location select 0, _cargo_location select 1, _height];
			_height = _height - _fall;
		};
		sleep 0.01;
		_retrycounter = _retrycounter + 1;			
   };
	_obj setPos [_cargo_location select 0, _cargo_location select 1, 0];

	sleep 0.1;
	_final_location = getPos _obj;
	_retrycounter = 0;
	while {(((abs(_final_location select 0) == 0) || (abs(_final_location select 0) == 1)) && ((abs(_final_location select 1) == 0) || (abs(_final_location select 1) == 1)) && ((abs(_final_location select 2) == 0) || (abs(_final_location select 2) == 1))) && (!(_retrycounter > 20))} do {
		_obj setPos [_cargo_location select 0, _cargo_location select 1, 0];
		sleep 0.1;
		_final_location = getPos _obj;
		_retrycounter = _retrycounter + 1;		
	};   

	_objectIDNum = parseNumber (_obj getVariable ["ObjectID","0"]);
	if (_objectIDNum > 0) then {
		_classname = (typeOf _obj);
		// Add to allowed update objects
		_flagaddedallowed = false;
		if (!(_classname in dayz_updateObjects) && _objectIDNum > 0) then {
			_flagaddedallowed = true;
			dayz_updateObjects	= dayz_updateObjects + [_classname];
		};

		dayzUpdateVehicle = [_obj, "positionnow-atl"];
		publicVariableServer "dayzUpdateVehicle";	
		
		// Remove from allowed update objects
		if (_flagaddedallowed) then {
			_flagaddedallowed = false;
			dayz_updateObjects	= dayz_updateObjects - [_classname];
		};	
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