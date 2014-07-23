#include "AdminTools-AccessList.sqf"

private ["_bg_usetime","_bg_curr_behavior","_bg_curr_engagement"];

_exitNow=false;

if ((getPlayerUID player) in _admins) then {
	_bg_usetime = 0;
	
} else {

	if !([_cost] call AC_fnc_checkAndRemoveRequirements) then {
		cutText ["\nYou do not have enough gold in your inventory.", "PLAIN DOWN"];
		_exitNow=true;
	} else {
		_exitNow=false;
	};



	_bg_usetime = 5;
};

if (_exitNow) exitWith {};  // No gold, lets gtfo

if (isNil ("bg_curr_bgs")) then {
	bg_curr_bgs = 0;
};
if (isNil ("bg_dismiss")) then {
	bg_dismiss = false;
};

if (isNil ("bg_time")) then {
	bg_time = time - (_bg_usetime + 1);
};

if (isNil ("bg_formation")) then {
	bg_formation = "NOTHING";
};

if ((isNil ("bg_behavior")) || (isNil ("bg_engagement"))) then {
	bg_engagement = "YELLOW";
	bg_behavior = "COMBAT";	
	TitleText ["Current Bodyguard Behavior: Combat(Keep Formation) / Kneel When Possible.", "PLAIN DOWN"];
};

if (bg_curr_bgs < bg_max_bgs) then {
	if ((time - bg_time) > _bg_usetime) then {
		bg_time = time;

		bg_dismiss = false;
		bg_curr_bgs = (bg_curr_bgs + 1);

		//TitleText [format["Bodyguard has your back son"], "PLAIN DOWN"];

		private["_spawnAIS", "_plrGroup"];

	//	CIVILIAN setFriend [WEST,0];
	//	WEST setFriend [CIVILIAN,0];

		if (rating player < 100000) then {
			player addRating 100000;
		};
		
		_plrGroup = (group player);
		_plrGroup allowFleeing 0;

		if (bg_formation == "NOTHING") then {
			_plrGroup setFormation "LINE";
		};
		
		// Random loadout

		_rndchoice = floor(random (count BG_Weapon_Loadouts));
		_bgloadoutselection = BG_Weapon_Loadouts select _rndchoice;


		_bgweaponselection = _bgloadoutselection select 0;
		_bgammoselection = _bgloadoutselection select 1;
		_bgammoqty = _bgloadoutselection select 2;
		_bgskinselection_bandit = _bgloadoutselection select 3;
		_bgskinselection_neut = _bgloadoutselection select 4;
		_bgskinselection_hero = _bgloadoutselection select 5;
		
		_humanity = player getVariable["humanity",0];
		
		_rndskin = floor(random (count _bgskinselection_neut));
		_skinToSpawn = _bgskinselection_neut select _rndskin;

		
		if (_humanity < -5000 ) then {
			_rndskin = floor(random (count _bgskinselection_bandit));
			_skinToSpawn = _bgskinselection_bandit select _rndskin;
		};
		
		if (_humanity > 5000 ) then {
			_rndskin = floor(random (count _bgskinselection_hero));
			_skinToSpawn = _bgskinselection_hero select _rndskin;

		};
		
		// spawn the guy

		if (_useHALO=="true") then {
			_skinToSpawn createUnit [[0, 0, 0], _plrGroup, "_spawnAIS = this;"];
		} else {
			_skinToSpawn createUnit [[(getpos player select 0), (getpos player select 1), (getpos player select 2)], _plrGroup, "_spawnAIS = this;"];
		};
		

		_spawnAIS enableAI "TARGET";
		_spawnAIS enableAI "AUTOTARGET";
		_spawnAIS enableAI "MOVE";
		_spawnAIS enableAI "ANIM";
		_spawnAIS enableAI "FSM";

		_spawnAIS allowDammage true;

		_spawnAIS setCombatMode bg_engagement;
		_spawnAIS setBehaviour bg_behavior;

		_bg_curr_engagement = bg_engagement;
		_bg_curr_behavior = bg_behavior;
		
		_spawnAIS addweapon _bgweaponselection;
		for "_i" from 1 to _bgammoqty do
		{
			_spawnAIS addMagazine _bgammoselection;
		};
		_spawnAIS selectWeapon _bgweaponselection;


		_spawnAIS setSkill ["aimingAccuracy",1];
		_spawnAIS setSkill ["aimingShake",1];
		_spawnAIS setSkill ["aimingSpeed",1];
		_spawnAIS setSkill ["endurance",1];
		_spawnAIS setSkill ["spotDistance",1];
		_spawnAIS setSkill ["spotTime",1];
		_spawnAIS setSkill ["courage",1];
		_spawnAIS setSkill ["reloadSpeed",1];
		_spawnAIS setSkill ["commanding",1];
		_spawnAIS setSkill ["general",1];
		
		if (_useHALO=="true") then {
		
			_veh = createVehicle ["UH1Y", [0,0,200], [],0,"fly"];
			
			_spawnAIS moveInCargo _veh;
			
			unassignvehicle _spawnAIS;
			_spawnAIS action ["EJECT",_veh];
			sleep 1;
			(vehicle _spawnAIS) setPos [(getpos player select 0), (getpos player select 1), (getpos player select 2) + 200];

			deleteVehicle _veh;
		
		};
		
		[_spawnAIS] join _plrGroup;
	
		_spawnAIS addEventHandler ["Fired", {_this call player_fired;}];

		while {alive _spawnAIS} do 
		{
			// {
			//	 _x addRating -9999999;
			// } forEach allMissionObjects "zZombie_Base"; // attacks zombies yo

	
			_nearbyzombies = player nearEntities [["zZombie_Base"],300];
			{
				if (rating _x > -100000) then {
					//diag_log ("Started Marking Zombies");						
					_x addRating -100000;
					//diag_log ("Name: " + (name _x) + " - Type: " + (typeOf _x) + " - Side: " + (format["%1",side _x]) + " - Rating: " + (format["%1",rating _x]));
					//diag_log ("Stopped Marking Zombies");
				};
			} foreach _nearbyzombies;

	
			_nearbyai = player nearEntities [["CAManBase"],300];
			{
				_sidename = format["%1",side _x];
				if ((_sidename == "east") || (_sidename == "resistance")) then {
					if (rating _x > -100000) then {
						//diag_log ("Started Marking AI");
						_x addRating -100000;
						//diag_log ("Name: " + (name _x) + " - Type: " + (typeOf _x) + " - Side: " + (format["%1",side _x]) + " - Rating: " + (format["%1",rating _x]));
						//diag_log ("Stopped Marking AI");
					};
				};
			} foreach _nearbyai;

			
			
			if (bg_dismiss) exitWith {};
			
			if (_bg_curr_engagement != bg_engagement) then {
				_spawnAIS setCombatMode bg_engagement;			
				_bg_curr_engagement = bg_engagement;
			};
			if (_bg_curr_behavior != bg_behavior) then {
				_spawnAIS setBehaviour bg_behavior;			
				_bg_curr_behavior = bg_behavior;
			};
			if (rating player < 100000) then {
				player addRating 100000;
			};
			sleep 1;
		};
		
		_spawnAIS setDamage 1;
		removeAllWeapons _spawnAIS; 
		removeAllItems _spawnAIS; 
		[_spawnAIS] join grpNull;

		bg_curr_bgs = (bg_curr_bgs - 1);
	} else {
		if (ceil (_bg_usetime - (time - bg_time)) == 1) then {
			TitleText [format["You have to wait %1 second before summoning more bodyguards.", ceil (_bg_usetime - (time - bg_time))], "PLAIN DOWN"];			
		} else {
			TitleText [format["You have to wait %1 seconds before summoning more bodyguards.", ceil (_bg_usetime - (time - bg_time))], "PLAIN DOWN"];			
		};
	};
} else {
	TitleText [format["You've reached your limit of %1 bodyguards.", bg_max_bgs], "PLAIN DOWN"];
};

if (bg_curr_bgs == 0) then {
	[player] join grpNull;
	bg_formation = "NOTHING";	
};

