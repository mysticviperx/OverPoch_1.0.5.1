// Epoch Admin Tools
//Replace 111111111 with your ID. 

#include "AdminTools-AccessList.sqf"

AdminList = _admins;

/*
AdminList = [
"17081926", // Mystic
"39688134", // Karhan
"20641734", // Hunyt
"129674950", // DeadHead
"65903622", //Ghosty
"13301062", // TheBumbiHunter 
"198461894" // Omega
];
*/
ModList = [
];

/*
	Base deletion variable. Default true.
	Determines default true or false for deleting all vehicles
	inside the base delete dome. Can be changed in game.
*/
BD_vehicles = true;




// DO NOT MODIFY ANYTHING BEYOND THIS POINT
tempList = []; 

/*
	Determines default on or off for admin tools menu
	Set this to false if you want the menu to be off by default.
	F11 turns the tool off, F10 turns it on.
	Leave this as True for now, it is under construction.
*/
if (isNil "toolsAreActive") then {toolsAreActive = true;};