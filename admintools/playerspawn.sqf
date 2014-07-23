//BlurGaming Intro Script
//Customized for Fortune Hunters by MVXHosting.com
//Credits: MysticViperX, Massaster, TheBumbiHunter

waitUntil {(!isNil 'dayz_locationCheck') || (!isNil 'dayz_animalcheck')};

#include "AdminTools-AccessList.sqf";

x = floor(random 4);    //0-3
y = floor(random 100);  //0-99
z = floor(random 100);  //1-100


_humanity = player getVariable["humanity",0];


if (((getPlayerUID player) in _members || (getPlayerUID player) in _mods || (getPlayerUID player) in _special || (getPlayerUID player) in _admins || (getPlayerUID player) in _donors) and (z <= 20)) then { //all admins
	playsound "intro_thankyou";
	sleep 15;
	cutText ["\nThankyou for Donating to the Server.\nWe cant be here with out your support.", "PLAIN DOWN"];
	} else {
	if (freshSpawn == 2) then {
		playsound "intro_halo";
		} else {
		if (x == 0) then {
			if (_humanity < -5000 ) then {	// if bandit
				playsound "bandit_baby";
			};
			if (_humanity > 5000 ) then {	// if hero
				playsound "hero_ezekiel";
			};
			if ((_humanity <= 5000) and (_humanity >=-5000))  then { // all else
				playsound "neutral_around";
			};
		};
		if (x == 1) then {
			if (_humanity < -5000 ) then {	// if bandit
				playsound "bandit_bad";
				if (y <= 25) then {
					sleep 15;
					cutText ["\n\nThe Badass Bicycle Fairies have heard your song and blessed you with a Bitchen bike.", "PLAIN DOWN"];
					_nill = execvm "admintools\Vehicles\Moto.sqf";
				};
			};
			if (_humanity > 5000 ) then {	// if hero
				playsound "hero_want";
				if (y <= 25) then {
					sleep 30;
					cutText ["\n\nThe Heroic Fairies have heard your song and blessed you with a Noble Steed.", "PLAIN DOWN"];
					_nill = execvm "admintools\Vehicles\M1030.sqf";
				};
			};
			if ((_humanity <= 5000) and (_humanity >=-5000))  then { // all else
				playsound "neutral_bike";
				if (y <= 50) then {
					sleep 22;
					cutText ["\n\nThe Magical Bicycle Fairies have heard your song and blessed you with a bike.", "PLAIN DOWN"];
					_nill = execvm "admintools\Vehicles\Bike.sqf";
				};
			};
		};
		if (x == 2) then {
			if (_humanity < -5000 ) then {	// if bandit
				playsound "bandit_riders";
			};
			if (_humanity > 5000 ) then {	// if hero
				playsound "hero_tiger";
			};
			if ((_humanity <= 5000) and (_humanity >=-5000))  then { // all else
				playsound "neutral_jungle";
			};
		};
		if (x == 3) then {
			if (_humanity < -5000 ) then {	// if bandit
				playsound "bandit_taken";
			};
			if (_humanity > 5000 ) then {	// if hero
				playsound "hero_hero";
			};
			if ((_humanity <= 5000) and (_humanity >=-5000))  then { // all else
				playsound "neutral_sweet";
			};
		};
	};
};

	[] execvm "Custom\Intro\server_welcome.sqf";