#include "AdminTools-AccessList.sqf"
call compile preprocessFileLineNumbers ("admintools\ac_functions.sqf");

_location = _this select 0;
Coords = [ 
	["Bash",[4011.1,11701.3,0.002],"Welcome to Bash Outpost."],
	["Kamenka",[1849.38,2145.33,0],"Welcome to Kamenka."],
	["Balota",[4928.03,2521.75,0],"Welcome to Balota Airfield."],
	["ChernoSniper",[6672.33,2620.1,36.469],"Welcome to Chernogorsk."],
	["EletroSniper",[10487.7,2784.82,0.001],"Eletro Sniper Pos.1"],
	["Skalisty",[13312,2728.9,1],"Welcome to Skalisty Island."],
	["Solnichniy",[13249.3,6076.25,0],"Welcome to Solnichniy Quarry."],
	["Berezino",[12682,9659.41,0],"Welcome to Berezino Lumber Mill."],
	["Gvozdno",[8536.99,11973.3,2],"Welcome to Gvozdno Tavern"],
	["Pustoshka",[3061.14,7850.67,0],"Welcome to Pustoshka Church."],
	["Zelenogorsk",[2924.85,5394.47,0],"Welcome to Zelenogorsk Industrial."],
	["NWAF",[4734.32,10297.7,0],"Welcome to Northwest Airfield."],
	["NEAF",[12188.2,12598.4,0.873],"Welcome to Northeast Airfield."],
	["Hero",[12882.6,12754.4,0],"You are now at Hero Camp."],
	["Klen",[11466.4,11384.6,0.002],"Welcome to Castle Klen."],
	["WHO",[10239.5,8903.00,0],"Welcome to W.H.O. Crash Site"],
	["Stary",[6381.81,7805.8,0.001],"Welcome to Stary Sobor."],
	["Bandit",[1594.82,7776.13,0],"You are now at Bandit's Den."],
	["Home",[12931.40,1473.64,16],"You are now at Home Base."],
	["Fall",[1124.29, 4145.71, 50],"Enjoy the Drop..."] 
];

cost = ["ItemGoldBar10oz",1];
costText = "\nYou do not have a 10oz goldbar in your inventory.";

if ((getPlayerUID player) in _admins) then {
	cost = ["ItemGoldBar",0];
	costText = "\nYou should not see this ;).";
};

if ((getPlayerUID player) in _mods) then {
	cost = ["ItemGoldBar",1];
	costText = "\nYou do not have a goldbar in your inventory.";
};


if !([cost] call AC_fnc_checkAndRemoveRequirements) then {
	cutText [costText, "PLAIN DOWN"];

} else {

	{
		tmp = _x select 0;
		if (tmp==_location) exitwith {
			posArray = [];
			posArray = _x select 1;
			
			player setpos posArray;
			[player, 1000] exec "ca\air2\halo\data\Scripts\HALO_init.sqs";
			titleText [_x select 2, "PLAIN DOWN"];
			titleFadeOut 2;
		};
	
	} forEach Coords;
};