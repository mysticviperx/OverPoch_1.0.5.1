
if (isNil ("debugMonitor")) then {
	debugMonitor = false;
};

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#include "AdminTools-AccessList.sqf"
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

serverrestarttimehours = 3;
serverrestarttimeseconds = ((serverrestarttimehours * 60) * 60);	
 
fnc_debug = {
	private ["_totalplayercount","_neutralCount","_heroCount","_banditCount","_pic","_tempsecondsleftuntilrestart","_serveruptime","_secondsleftuntilrestart","_hoursuntilrestart","_minutesuntilrestart","_secondsuntilrestart","_minutesuntilrestartstring","_secondsuntilrestartstring","_timeuntilrestart"];

    debugMonitor = true;
    while {debugMonitor} do
    {
        _kills =        player getVariable["zombieKills",0];
        _killsH =        player getVariable["humanKills",0];
        _killsB =        player getVariable["banditKills",0];
        _humanity =        player getVariable["humanity",0];
        _headShots =    player getVariable["headShots",0];
        _zombies =              count entities "zZombie_Base";
        _zombiesA =    {alive _x} count entities "zZombie_Base";
        
		_totalplayercount = (count playableUnits);
        _banditCount = {(isPlayer _x) && ((_x getVariable ["humanity",0]) < -4999)} count playableUnits;
        _heroCount  = {(isPlayer _x) && ((_x getVariable ["humanity",0]) > 4999)} count playableUnits;
		_neutralCount = (_totalplayercount - (_banditCount + _heroCount));

		//_AICount = PV_AICount select 0;
		//_AIHeliCount = PV_AICount select 1;		
		
		//_AICount = (({alive _x} count KRON_AllWest) + ({alive _x} count KRON_AllEast) + ({alive _x} count KRON_AllRes));		
		//_AIHeliCount = 0;
		
        _pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
		if (player == vehicle player) then {
			_pic = (gettext (configFile >> 'cfgWeapons' >> (currentWeapon player) >> 'picture'));
		} else {
			_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
		};

		_serveruptime = ServerTime + 36;
		_secondsleftuntilrestart = (serverrestarttimeseconds - _serveruptime);
		_tempsecondsleftuntilrestart = _secondsleftuntilrestart;

		_tempsecondsleftuntilrestart = (_tempsecondsleftuntilrestart mod 86400);
		if (_tempsecondsleftuntilrestart > 3599) then {
			_hoursuntilrestart = (floor (_tempsecondsleftuntilrestart / 3600));
		} else {
			_hoursuntilrestart = 0;		
		};
		_tempsecondsleftuntilrestart = (_tempsecondsleftuntilrestart mod 3600);
		if (_tempsecondsleftuntilrestart > 59) then {
			_minutesuntilrestart = (floor (_tempsecondsleftuntilrestart / 60));
		} else {
			_minutesuntilrestart = 0;		
		};		
		_tempsecondsleftuntilrestart = (_tempsecondsleftuntilrestart mod 60);
		_secondsuntilrestart = (floor (_tempsecondsleftuntilrestart));
		

		if (_minutesuntilrestart > 9) then {
			_minutesuntilrestartstring = format["%1",_minutesuntilrestart];		
		} else {
			_minutesuntilrestartstring = format["0%1",_minutesuntilrestart];				
		};
		if (_secondsuntilrestart > 9) then {
			_secondsuntilrestartstring = format["%1",_secondsuntilrestart];		
		} else {
			_secondsuntilrestartstring = format["0%1",_secondsuntilrestart];				
		};
		_timeuntilrestart = format["%1h %2m",_hoursuntilrestart,_minutesuntilrestartstring];

		//			<t font='TahomaB'align='left'color='#FFBF00'>AI Count(normal/heli):</t><t font='TahomaB'align='right'>%17/%18</t><br/>	
		
		hintSilent parseText format ["
			<t font='TahomaB'align='left'>[%1]</t><t font='TahomaB'align='right'>[FPS:%10]</t><br/>
			<t font='TahomaB'align='center'color='#3366FF'>Survived %14 Days</t><br/>		
			<t font='TahomaB'align='left'color='#EE0000'>Blood:</t><t font='TahomaB'align='right'>%2</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Humanity:</t><t font='TahomaB'align='right'>%3</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Survivors Killed:</t><t font='TahomaB'align='right'>%4</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Bandits Killed:</t><t font='TahomaB'align='right'>%5</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Zombies Killed:</t><t font='TahomaB'align='right'>%6</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Head Shots:</t><t font='TahomaB'align='right'>%7</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Zombies(alive/total):</t><t font='TahomaB'align='right'>%9/%8</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Bodyguards (alive/max):</t><t font='TahomaB'align='right'>%19/%20</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Heroes Online:</t><t font='TahomaB'align='right'>%12</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Neutrals Online:</t><t font='TahomaB'align='right'>%16</t><br/>			
			<t font='TahomaB'align='left'color='#FFBF00'>Bandits Online:</t><t font='TahomaB'align='right'>%11</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Server Restart In:</t><t font='TahomaB'align='right'>%15</t><br/>			
			<t font='TahomaB'align='center'><img size='3' image='%13'/></t><br />
			<t font='TahomaB'align='center'color='#FFBF00'>Press [INS] to close</t><br />		
			",
			(gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName')),
			floor r_player_blood,
			round _humanity,
			_killsH,
			_killsB,
			_kills,
			_headShots,
			count entities "zZombie_Base",
			{alive _x} count entities "zZombie_Base",
			(round diag_fps),
			_banditCount,
			_heroCount,
			_pic,
			(dayz_Survived),
			_timeuntilrestart,
			_neutralcount,
			_AICount,
			_AIHeliCount, 
			bg_curr_bgs,
			bg_max_bgs
		];
		sleep 1;
    };
};


fnc_debug2 = {
	private ["_totalplayercount","_neutralCount","_heroCount","_banditCount","_pic","_tempsecondsleftuntilrestart","_serveruptime","_secondsleftuntilrestart","_hoursuntilrestart","_minutesuntilrestart","_secondsuntilrestart","_minutesuntilrestartstring","_secondsuntilrestartstring","_timeuntilrestart"];

    debugMonitor = true;
    while {debugMonitor} do
    {
    	
		_serveruptime = ServerTime + 36;
		_secondsleftuntilrestart = (serverrestarttimeseconds - _serveruptime);
		_tempsecondsleftuntilrestart = _secondsleftuntilrestart;

		_tempsecondsleftuntilrestart = (_tempsecondsleftuntilrestart mod 86400);
		if (_tempsecondsleftuntilrestart > 3599) then {
			_hoursuntilrestart = (floor (_tempsecondsleftuntilrestart / 3600));
		} else {
			_hoursuntilrestart = 0;		
		};
		_tempsecondsleftuntilrestart = (_tempsecondsleftuntilrestart mod 3600);
		if (_tempsecondsleftuntilrestart > 59) then {
			_minutesuntilrestart = (floor (_tempsecondsleftuntilrestart / 60));
		} else {
			_minutesuntilrestart = 0;		
		};		
		_tempsecondsleftuntilrestart = (_tempsecondsleftuntilrestart mod 60);
		_secondsuntilrestart = (floor (_tempsecondsleftuntilrestart));
		

		if (_minutesuntilrestart > 9) then {
			_minutesuntilrestartstring = format["%1",_minutesuntilrestart];		
		} else {
			_minutesuntilrestartstring = format["0%1",_minutesuntilrestart];				
		};
		if (_secondsuntilrestart > 9) then {
			_secondsuntilrestartstring = format["%1",_secondsuntilrestart];		
		} else {
			_secondsuntilrestartstring = format["0%1",_secondsuntilrestart];				
		};
		_timeuntilrestart = format["%1h %2m",_hoursuntilrestart,_minutesuntilrestartstring];

		_totalplayercount = (count playableUnits);
        _banditCount = {(isPlayer _x) && ((_x getVariable ["humanity",0]) < -4999)} count playableUnits;
        _heroCount  = {(isPlayer _x) && ((_x getVariable ["humanity",0]) > 4999)} count playableUnits;
		_neutralCount = (_totalplayercount - (_banditCount + _heroCount));

		//_AICount = PV_AICount select 0;
		//_AIHeliCount = PV_AICount select 1;		

		//_AICount = (({alive _x} count KRON_AllWest) + ({alive _x} count KRON_AllEast) + ({alive _x} count KRON_AllRes));		
		//_AIHeliCount = 0;		
		
        _pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
		if (player == vehicle player) then {
			_pic = (gettext (configFile >> 'CfgWeapons' >> (currentWeapon player) >> 'picture'));
		} else {
			_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
		};
		
		//			<t font='TahomaB'align='left'color='#FFBF00'>AI Count(normal/heli):</t><t font='TahomaB'align='right'>%29/%30</t><br/>	

		hintSilent parseText format ["
			<t font='TahomaB'align='left'>[%18]</t><t font='TahomaB'align='right'>[FPS: %10]</t><br/>
			<t font='TahomaB'align='center'color='#3366FF'>Survived %7 Days</t><br/>
			<t font='TahomaB'align='left'>Players: %8</t><t font='TahomaB'align='right'>Within 500m: %11</t><br/>
			<t font='TahomaB'align='left'>Vehicles: %13(%14)</t><t font='TahomaB'align='right'>Bikes: %15</t><br/>
			<t font='TahomaB'align='left'>Air: %16</t><t font='TahomaB'align='center'>Sea: %23</t><t font='TahomaB'align='right'>Cars: %17</t><br/>
			<t font='TahomaB'align='left'color='#EE0000'>Blood</t><t font='TahomaB'align='left'color='#FFBF00'>/Humanity:</t><t size='.9'font='TahomaB'align='right'>%9/%6</t><br/>				
			<t font='TahomaB'align='left'color='#FFBF00'>Surv/Bandit Kills: </t><t font='TahomaB'align='right'>%4/%5</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Zombie Kills:</t><t font='TahomaB'align='right'>%2</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Headshots:</t><t font='TahomaB'align='right'>%3</t><br/>			
			<t font='TahomaB'align='left'color='#FFBF00'>Hero/Neut/Band Online: </t><t font='TahomaB'align='right'>%25/%28/%26</t><br/>	
			<t font='TahomaB'align='left'color='#FFBF00'>Zombies(alive/total): </t><t font='TahomaB'align='right'>%20(%19)</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Bodyguards (alive/max):</t><t font='TahomaB'align='right'>%31/%32</t><br/>
			<t font='TahomaB'align='left'color='#FFBF00'>Server Restart In: </t><t font='TahomaB'align='right'>%27</t><br/>				
			<t font='TahomaB'align='left'>GPS: %22</t><t font='TahomaB'align='right'>DIR: %24</t><br/>
			<t font='TahomaB'align='center'>%21</t><br/>
			<t align='center'><img size='3'image='%1'/></t><br />
			<t font='TahomaB' color='#FFBF00' align='center'>Press [INS] to close</t><br/>				
			",
			_pic,
			(player getVariable['zombieKills', 0]),
			(player getVariable['headShots', 0]),
			(player getVariable['humanKills', 0]),
			(player getVariable['banditKills', 0]),
			(player getVariable['humanity', 0]),
			(dayz_Survived),
			_totalplayercount,
			floor r_player_blood,
			(round diag_fps),
			abs (({isPlayer _x} count (getPos vehicle player nearEntities [["AllVehicles"], 500]))-1),
			viewdistance,
			(count([6800, 9200, 0] nearEntities [["StaticWeapon","Car","Motorcycle","Tank","Air","Ship"],25000])),
			count vehicles,
			(count([6800, 9200, 0] nearEntities [["Motorcycle"],25000])),
			(count([6800, 9200, 0] nearEntities [["Air"],25000])),
			(count([6800, 9200, 0] nearEntities [["Car"],25000])),
			(gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName')),
			(count entities "zZombie_Base"),
			({alive _x} count entities "zZombie_Base"),
			(getPosASL player),
			(mapGridPosition getPos player),
			(count([6800, 9200, 0] nearEntities [["Ship"],25000])),
			(round(getDir player)),
			_heroCount,
			_banditCount,
			_timeuntilrestart,
			_neutralcount,
			_AICount,
			_AIHeliCount,
			bg_curr_bgs,
			bg_max_bgs
		];
		sleep 1;
    };
};

if (debugMonitor) then {
	debugMonitor = false;
	hintSilent "";
} else {
	if ((getPlayerUID player) in _members || (getPlayerUID player) in _mods || (getPlayerUID player) in _admins || (getPlayerUID player) in _donors) then {		
		[] spawn fnc_debug2;
	} else {
		[] spawn fnc_debug;			
	};
};
