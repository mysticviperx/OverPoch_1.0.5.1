#include "AdminTools-AccessList.sqf"

_pathtobg = "admintools\";
_EXECbgscript1 = 'player execVM "'+_pathtobg+'%1"';
_EXECbgscript2 = '["%2"] execVM "'+_pathtobg+'%1"';

if ((isNil ("bg_behavior")) || (isNil ("bg_engagement"))) then {
	bg_engagement = "RED";
	bg_behavior = "COMBAT";	
	TitleText ["Current Bodyguard Behavior: Combat(Free Will) / Kneel When Possible.", "PLAIN DOWN"];
};


if ((getPlayerUID player) in _admins) then {
	BGMenu =
	[
		["",true],
			["Call Normal Bodyguard", [2],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-normal.sqf", "false"]]], "1", "1"],
			["Call Silent Bodyguard", [3],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-silent.sqf", "false"]]], "1", "1"],
			["Call Super Bodyguard", [4],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-superbodyguard.sqf", "false"]]], "1", "1"],
			["Call HALO Normal Bodyguard", [5],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-normal.sqf", "true"]]], "1", "1"],
			["Call HALO Silent Bodyguard", [6],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-silent.sqf", "true"]]], "1", "1"],
			["Call HALO Super Bodyguard", [7],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-superbodyguard.sqf", "true"]]], "1", "1"],
			["Change Behavior", [8],  "#USER:BGBehaviorMenu", -5, [["expression", ""]], "1", "1"],	
			["Dismiss Bodyguards", [9],  "", -5, [["expression", format[_EXECbgscript1,"bodyguard-dismiss.sqf"]]], "1", "1"],		
			["", [-1], "", -5, [["expression", ""]], "1", "0"],
			
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
	];

} else {
	BGMenu =
	[
		["",true],
			["Call Normal Bodyguard", [2],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-normal.sqf","true"]]], "1", "1"],
			["Call Silent Bodyguard", [3],  "", -5, [["expression", format[_EXECbgscript2,"bodyguard-silent.sqf","true"]]], "1", "1"],
			["Change Behavior", [4],  "#USER:BGBehaviorMenu", -5, [["expression", ""]], "1", "1"],	
			["Dismiss Bodyguards", [5],  "", -5, [["expression", format[_EXECbgscript1,"bodyguard-dismiss.sqf"]]], "1", "1"],		
			["", [-1], "", -5, [["expression", ""]], "1", "0"],
			
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
	];
};


BGBehaviorMenu =
[
	["",true],
		["Stance Behavior", [2],  "#USER:BGStanceMenu", -5, [["expression", ""]], "1", "1"],
		["Engagement Behavior", [3],  "#USER:BGEngagementMenu", -5, [["expression", ""]], "1", "1"],		
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];


BGStanceMenu =
[
	["",true],
		["Careless", [2], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-behavior.sqf","CARELESS"]]], "1", "1"],
		["Kneel When Possible", [3], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-behavior.sqf","COMBAT"]]], "1", "1"],
		["Prone When Possible", [4], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-behavior.sqf","STEALTH"]]], "1", "1"],	
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

BGEngagementMenu =
[
	["",true],
		["Never Fire", [2], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-engagement.sqf","BLUE"]]], "1", "1"],
		["Passive", [3], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-engagement.sqf","GREEN"]]], "1", "1"],
		["Defensive", [4], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-engagement.sqf","WHITE"]]], "1", "1"],
		["Combat(Keep Formation)", [5], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-engagement.sqf","YELLOW"]]], "1", "1"],
		["Combat(Free Will)", [6], "", -5, [["expression", format[_EXECbgscript2,"bodyguard-engagement.sqf","RED"]]], "1", "1"],		
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:BGMenu";
