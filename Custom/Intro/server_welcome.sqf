/* 	*********************************************************************** */

/*	=======================================================================
/*	SCRIPT NAME: Server Intro Credits Script by IT07
/*	SCRIPT VERSION: v1.3.4 BETA
/*	Credits for original script: Bohemia Interactive http://bistudio.com
/*	=======================================================================

/*	*********************************************************************** */

//	========== SCRIPT CONFIG ============
	
_onScreenTime = 8; 		//how long one role should stay on screen. Use value from 0 to 10 where 0 is almost instant transition to next role 
//NOTE: Above value is not in seconds!

//	==== HOW TO CUSTOMIZE THE CREDITS ===
//	If you want more or less credits on the screen, you have to add/remove roles.
//	Watch out though, you need to make sure BOTH role lists match eachother in terms of amount.
//	Just take a good look at the _role1 and the rest and you will see what I mean.

//	For further explanation of it all, I included some info in the code.

//	== HOW TO CUSTOMIZE THE COLOR OF CREDITS ==
//	Find line **** and look for: color='#f2cb0b'
//	The numbers and letters between the 2 '' is the HTML color code for a certain yellow.
//	If you want to change the color of the text, search on google for HTML color codes and pick the one your like.
//	Then, replace the existing color code for the code you would like to use instead. Don't forget the # in front of it.
//	HTML Color Codes Examples:	
//	#FFFFFF (white)
//	#000000 (black)	No idea why you would want black, but whatever
//	#C80000 (red)
//	#009FCF (light-blue)
//	#31C300 (Razer Green)			
//	#FF8501 (orange)
//  $f2cb0b (Yellow)
//	===========================================


//	SCRIPT START

waitUntil { sleep 1; alive player };
sleep 2;
waituntil {sleep 1; !isnull (finddisplay 46)};
sleep 5; //Wait in seconds before the credits start after player loads into the game

_role1 = "Welcome to";
_role1names = ["Fortune Hunter's OverPoch Sauerland Server","v1.0.5.1"];
_role2 = "Hosted by";
_role2names = ["MVXHosting"];
_role3 = "Administrators";
_role3names = ["[MVX] Mystic (Owner)","[FOX] Karhan (Operations)","[THE] BumbiHunter (Fixer)","[CAN] Hunyt (Founder)"];
_role4 = "Server rules:";
_role4names = ["Be polite in side chat.", "Please Don't whine to the Admins.", "No voice over sidechat!","No Stream Sniping"];
_role5 = "Website";
_role5names = ["http://dayz.mvxhosting.com", "Forums and server information.", "News and Updates", "Price list for all vendors."];
_role6 = "Features";				
_role6names = ["Hardcore AI and Heli Patrols","Mission System with Epoch Loot","Vehicle Towing and Lifting","Refuel and Repair at Gas Pumps","Improved Building with Snapping","Self Blood-Bagging","Custom Starting Load-out"];
_role7 = "Features";				
_role7names = ["Custom Map Edits","New Trader Cities","Indestructible Bases","Trader Safe Zones","Call Bodyguards with Radio","Random Easter-eggs","Donator Perks"];
_role8 = "Recent Updates";				
_role8names = ["This server is still in testing","Please be patient as we add more features,","squash bugs, and update the traders"];
_role9 = "Special Thanks:";				
_role9names = ["DeadHead, Ghosty,","GUIDO FROM NY, Viral Blu,","TheMrRigs, Cyclops, Morgan,","Neekou, Heios, Dido,","SuperDeluxe, Negamax, Az_Mick,","OMEGA, Logan, NinjaChicken,","Xoury, Wyatt, and Phill"];


{
	sleep 2;
	_memberFunction = _x select 0;
	_memberNames = _x select 1;
	_finalText = format ["<t size='0.70' color='#f2cb0b' align='left'>%1<br /></t>", _memberFunction]; //right
	_finalText = _finalText + "<t size='0.55' color='#FFFFFF' align='left'>"; //right CDC9C9	d3d3d3
	{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
	_finalText = _finalText + "</t>";
	_onScreenTime + (((count _memberNames) - 1) * 0.5);
	[
		_finalText,
		[safezoneX + safezoneW - 0.8,0.50],	//DEFAULT: 0.5,0.35
		[safezoneY + safezoneH - 0.8,0.7], 	//DEFAULT: 0.8,0.7
		_onScreenTime,
		0.5
	] spawn BIS_fnc_dynamicText;
	sleep (_onScreenTime);
} forEach [
	//The list below should have exactly the same amount of roles as the list above
	[_role1, _role1names],
	[_role2, _role2names],
	[_role3, _role3names],
	[_role4, _role4names],
	[_role5, _role5names],
	[_role6, _role6names],
	[_role7, _role7names],
	[_role8, _role8names],
	[_role9, _role9names]
];
