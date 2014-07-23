/***********************************************************
	ADD-IN TO ACTIONS FOR SELF #1
************************************************************/

private ["_admins","_mods","_members","_donors","_convertownerID","_tempKeyName","_showowner","_shitters","_shittercount"];	

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#include "AdminTools-AccessList.sqf"
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


if (isNil ("lastRevealTime")) then {
	lastRevealTime = time - 2;
};


_lastRevealTime = time - lastRevealTime;
if (_lastRevealTime > 1) then {
	//diag_log (format["Reveal Time: %1",_lastRevealTime]);
	_reveallist = player nearEntities 5;
	lastRevealTime = time;
	{
		player reveal _x;
	} forEach _reveallist;
};


// ---------------------------------------Fix Add Actions Start--------------------------------------------
// If they hit the ` key it will reset the admin and pickup menus.
if (isNil ("s_player_fix_actions")) then {
	if ((getPlayerUID player) in _members || (getPlayerUID player) in _mods || (getPlayerUID player) in _admins || (getPlayerUID player) in _donors) then {
		s_player_fix_actions = 1;
		keyfixactions = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 41) then {player removeAction s_player_adminmenu; s_player_adminmenu = -1; s_player_curr_skin = typeOf player; player removeAction s_player_objectmovemenu_pickup; s_player_objectmovemenu_pickup = -1; player removeAction s_player_objectmovemenu_dothings1; player removeAction s_player_objectmovemenu_dothings2; player removeAction s_player_objectmovemenu_dothings3; player removeAction s_player_objectmovemenu_dothings4; s_player_objectmovemenu_dothings1 = -1; s_player_objectmovemenu_dothings2 = -1; s_player_objectmovemenu_dothings3 = -1; s_player_objectmovemenu_dothings4 = -1; s_player_curr_skin2 = typeOf player;}"];
	} else {
		s_player_fix_actions = 1;	
	};
};
// ---------------------------------------Fix Add Actions End----------------------------------------------

/*
// ---------------------------------------Admin Menu Start--------------------------------------------
if ((getPlayerUID player) in _members || (getPlayerUID player) in _mods || (getPlayerUID player) in _admins || (getPlayerUID player) in _donors) then {	
	if (isNil ("s_player_adminmenu")) then {
		s_player_adminmenu = -1;
		s_player_curr_skin = typeOf player;
	};
	if (_canDo && s_player_curr_skin == typeOf player) then {

			if (s_player_adminmenu < 0) then {
				//cutText ["Got here ADD!", "PLAIN DOWN"];		
				s_player_adminmenu = player addaction [("<t color=""#0074E8"">" + ("Tools Menu") +"</t>"),"admintools\Eexcute.sqf","",6,false,true,"",""];
			};

	} else {
		player removeAction s_player_adminmenu;
		s_player_adminmenu = -1;
		s_player_curr_skin = typeOf player;	
		//cutText ["Got here Remove!", "PLAIN DOWN"];			
	};	
};
// ---------------------------------------Admin Menu End----------------------------------------------------
*/

// ---------------------------------------Object Move Menu Start--------------------------------------------

if ((getPlayerUID player) in _admins) then {
	if (isNil ("IDC_cargo_towed")) then {
		IDC_cargo_towed = objNull;
	};
	if (isNil ("s_player_objectmovemenu_pickup")) then {
		s_player_objectmovemenu_pickup = -1;
		s_player_objectmovemenu_dothings1 = -1;	
		s_player_objectmovemenu_dothings2 = -1;	
		s_player_objectmovemenu_dothings3 = -1;	
		s_player_objectmovemenu_dothings4 = -1;	
		s_player_curr_skin2 = typeOf player;
	};
	//(speed player <= 1) && 
	if (_canDo && s_player_curr_skin2 == typeOf player) then {
		if (isNull (IDC_cargo_towed)) then {
			player removeAction s_player_objectmovemenu_dothings1;
			player removeAction s_player_objectmovemenu_dothings2;
			player removeAction s_player_objectmovemenu_dothings3;
			player removeAction s_player_objectmovemenu_dothings4;	
			s_player_objectmovemenu_dothings1 = -1;	
			s_player_objectmovemenu_dothings2 = -1;	
			s_player_objectmovemenu_dothings3 = -1;	
			s_player_objectmovemenu_dothings4 = -1;	
			if (s_player_objectmovemenu_pickup < 0) then {
				s_player_objectmovemenu_pickup = player addaction [("<t color=""#00CCFF"">" + ("Pick Up Object") +"</t>"),"admintools\tools\moveobj-start.sqf","",5,false,true,"",""];			
			};
		} else {
				player removeAction s_player_objectmovemenu_pickup;
				s_player_objectmovemenu_pickup = -1;
				
				if (s_player_objectmovemenu_dothings1 < 0) then {
					//cutText ["Got here ADD!", "PLAIN DOWN"];
					s_player_objectmovemenu_dothings1 = player addaction [("<t color=""#9900FF"">" + ("Undo Pickup Of Object") +"</t>"),"admintools\tools\moveobj-undo.sqf","",5,false,true,"",""];				
				};
				if (s_player_objectmovemenu_dothings2 < 0) then {
					//cutText ["Got here ADD!", "PLAIN DOWN"];
					s_player_objectmovemenu_dothings2 = player addaction [("<t color=""#00CCFF"">" + ("Drop Held Object") +"</t>"),"admintools\tools\moveobj-stop.sqf","",5,false,true,"",""];				
				};
				if (s_player_objectmovemenu_dothings3 < 0) then {
					//cutText ["Got here ADD!", "PLAIN DOWN"];
					s_player_objectmovemenu_dothings3 = player addaction [("<t color=""#FFFF00"">" + ("Copy Held Object") +"</t>"),"admintools\tools\moveobj-copy.sqf","",5,false,true,"",""];
				};
				if (s_player_objectmovemenu_dothings4 < 0) then {
					//cutText ["Got here ADD!", "PLAIN DOWN"];
					s_player_objectmovemenu_dothings4 = player addaction [("<t color=""#FF0000"">" + ("Delete Held Object") +"</t>"),"admintools\tools\moveobj-delete.sqf","",5,false,true,"",""];				
				};			
		};
	} else {
		player removeAction s_player_objectmovemenu_pickup;
		s_player_objectmovemenu_pickup = -1;
		
		player removeAction s_player_objectmovemenu_dothings1;
		player removeAction s_player_objectmovemenu_dothings2;
		player removeAction s_player_objectmovemenu_dothings3;
		player removeAction s_player_objectmovemenu_dothings4;	
		s_player_objectmovemenu_dothings1 = -1;	
		s_player_objectmovemenu_dothings2 = -1;	
		s_player_objectmovemenu_dothings3 = -1;	
		s_player_objectmovemenu_dothings4 = -1;		
		
		s_player_curr_skin2 = typeOf player;	
		//cutText ["Got here Remove!", "PLAIN DOWN"];			
	};	
};
// ---------------------------------------Object Move Menu End----------------------------=-----------------

// ----------------------------------------Taunt Zombies Start----------------------------------------------
if ((cursorTarget isKindOf "zZombie_base") and (alive cursorTarget) and !_inVehicle and _canDo and (player distance CursorTarget < 51)) then {
	if (s_player_tauntzed < 0) then {
		_hasKnife = "ItemKnife" in items player;	  
		if (!_hasKnife) then {
			s_player_tauntzed = player addAction [("<t color=""#A0A0A0"">" + ("Taunt nearby zombies (Bleed and Scream)") + "</t>"), "Scripts\player_tauntnearbyzed.sqf",[], 1, false, true, "", ""];
		} else {
			s_player_tauntzed = player addAction [("<t color=""#FF3232"">" + ("Taunt nearby zombies (Bleed and Scream)") + "</t>"), "Scripts\player_tauntnearbyzed.sqf",[], 1, false, true, "", ""];
		};
	};
} else {
	player removeAction s_player_tauntzed;
	s_player_tauntzed = -1;
};
// ----------------------------------------Taunt Zombies End----------------------------------------------

/*
// ---------------------------------------Krixes Self Bloodbag Start------------------------------------
_mags = magazines player;

// Krixes Self Bloodbag
if ("ItemBloodbag" in _mags) then {
    hasBagItem = true;
} else { 
	hasBagItem = false;
};
if((speed player <= 1) && hasBagItem && _canDo) then {
    if (s_player_selfBloodbag < 0) then {
        s_player_selfBloodbag = player addaction[("<t color=""#c70000"">" + ("Self Bloodbag") +"</t>"),"Scripts\player_selfbloodbag.sqf","",4,false,true,"", ""];
    };
} else {
    player removeAction s_player_selfBloodbag;
    s_player_selfBloodbag = -1;
};
// ---------------------------------------Krixes Self Bloodbag End------------------------------------
*/

// ---------------------------------------Bodyguard Start------------------------------------
if (isNil ("bg_curr_bgs")) then {
	bg_curr_bgs = 0;
	bg_max_bgs = 2;			
	if ((getPlayerUID player) in _admins) then {
		bg_max_bgs = 30;
	} else {
		if ((getPlayerUID player) in _members) then {
			bg_max_bgs = 4;			
		};
		
		if ((getPlayerUID player) in _mods ) then {
			bg_max_bgs = 5;			
		};
		
		if ((getPlayerUID player) in _donors) then {
			bg_max_bgs = 3;			
		};

	};	
};

_hasradio = "ItemRadio" in items player;
if ((speed player <= 1) && _canDo && (_hasradio || ((getPlayerUID player) in _admins))) then {
    if (s_player_bg < 0) then {
        s_player_bg = player addaction[("<t color=""#00FF00"">" + ("Bodyguard Menu") +"</t>"),"admintools\bodyguard-launch.sqf","",0,false,true];
    };
} else {
    player removeAction s_player_bg;
    s_player_bg = -1;
};
// -----------------------------------------Bodyguard End------------------------------------



// ---------------------------------------Fire Dance Start--------------------------------------------
if (inflamed cursorTarget and _canDo) then {
		if (s_player_dance < 0) then {
		s_player_dance = player addAction ["Rain Dance Mother Fucker","Scripts\dance.sqf",cursorTarget, 0, false, true, "",""];
	};
} else {
	player removeAction s_player_dance;
	s_player_dance = -1;
};
// ---------------------------------------Fire Dance End----------------------------------------------

// ---------------------------------------Shitter Port Start--------------------------------------------

if (((getPlayerUID player) in _members || (getPlayerUID player) in _mods || (getPlayerUID player) in _admins || (getPlayerUID player) in _donors) and _canDo) then {
	if (isNil ("s_player_tp")) then {
		s_player_tp = -1;		
	};
	_shitters = nearestObjects [position player, ["Land_KBud","OutHouse_DZ"], 5];
	_shittercount = count _shitters;
	if (_shittercount > 0) then {
		if (s_player_tp < 0) then {
			s_player_tp = player addaction[("<t color=""#FFFF00"">" + ("HALO Jump") + "</t>"),"admintools\tools\ShitterPorter.sqf","",4,false,true];	
		};
	} else {
		player removeAction s_player_tp;
		s_player_tp = -1;	
	};
};
// ---------------------------------------Shitter Port End----------------------------------------------


/*
// -------------------------------------Zombie Shield Start---------------------------------------------
_mags = magazines player;
if (("ItemGoldBar10oz" in _mags) && ("PartEngine" in _mags) && ("ItemJerrycan" in _mags) && ("ItemToolbox" in items player) && ("ItemRadio" in items player)) then {
    hasShield = true;
} else {
    hasShield = false;
};
if (hasShield) then {
    if (zombieShield < 0) then {
    zombieShield = player addAction [("<t color=""#00c362"">" + ("Anti-Zombie Freq Emitter") +"</t>"),"Scripts\zombieshield.sqf","",5,false,true,"",""];
    };
} else {
    player removeAction zombieShield;
    zombieShield = -1;
};
// ---------------------------------------Zombie Shield End---------------------------------------------
*/