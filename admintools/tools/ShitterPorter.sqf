_EXECscript6 = '["%1"] execVM "admintools\doportertele.sqf"';


//WAYPOINT MENUS
TeleportWaypointMenu =
[
	["",true],
		["Kamenka Docks", [2],  "", -5, [["expression", format[_EXECscript6,"Kamenka"]]], "1", "1"], 
		["Balota Airfield", [3],  "", -5, [["expression", format[_EXECscript6,"Balota"]]], "1", "1"],
		["Cherno Sniper", [4],  "", -5, [["expression", format[_EXECscript6,"ChernoSniper"]]], "1", "1"],
		["Elektro Sniper", [5],  "", -5, [["expression", format[_EXECscript6,"EletroSniper"]]], "1", "1"],
		["Skalisty Light House", [6],  "", -5, [["expression", format[_EXECscript6,"Skalisty"]]], "1", "1"],
		["Solnichniy Quarry", [7],  "", -5, [["expression", format[_EXECscript6,"Solnichniy"]]], "1", "1"],
		["Berezino Lumber Mill", [8],  "", -5, [["expression", format[_EXECscript6,"Berezino"]]], "1", "1"],			
		["Gvozdno Tavern", [9],  "", -5, [["expression", format[_EXECscript6,"Gvozdno"]]], "1", "1"],
		["Pustoshka Church", [10],  "", -5, [["expression", format[_EXECscript6,"Pustoshka"]]], "1", "1"],
		["Zelenogorsk Industrial", [11],  "", -5, [["expression", format[_EXECscript6,"Zelenogorsk"]]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		
		["Next Page", [12], "#USER:TeleportWaypointMenu2", -5, [["expression", ""]], "1", "1"],
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];
TeleportWaypointMenu2 =
[
	["",true],
		["Northwest Airfield", [2],  "", -5, [["expression", format[_EXECscript6,"NWAF"]]], "1", "1"],
		["Northeast Airfield", [3],  "", -5, [["expression", format[_EXECscript6,"NEAF"]]], "1", "1"],
		["Hero Camp", [4],  "", -5, [["expression", format[_EXECscript6,"Hero"]]], "1", "1"],
		["Castle Klen", [5],  "", -5, [["expression", format[_EXECscript6,"Klen"]]], "1", "1"],
		["W.H.O. Crash Site", [6],  "", -5, [["expression", format[_EXECscript6,"WHO"]]], "1", "1"],
		["Stary Sobor", [7],  "", -5, [["expression", format[_EXECscript6,"Stary"]]], "1", "1"],
		["Bash Outpost", [8],  "", -5, [["expression", format[_EXECscript6,"Bash"]]], "1", "1"],
		["Bandit Den", [9],  "", -5, [["expression", format[_EXECscript6,"Bandit"]]], "1", "1"],
		["Carrier !!!ADMIN/MOD ONLY!!!", [10],  "", -5, [["expression", format[_EXECscript6,"Home"]]], "1", "1"],			
		["Suicide", [11],  "", -5, [["expression", format[_EXECscript6,"Fall"]]], "1", "1"],			
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:TeleportWaypointMenu";