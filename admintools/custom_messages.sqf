private ["_message"];

if (isNil ("debugMonitor")) then {
	debugMonitor = false;
};

sleep 240;
	
while {true} do {
	_message = "<t size='1.1' color='#FFCC33' font='TahomaB'align='left'>Donations can be made to help pay for server hosting fees at our website http://dayz.mvxhosting.com (Click on the PAYPAL Donate button on the left side of the page.)</t><br/><br/><t size='1.1' color='#FFFFFF' font='TahomaB'align='left'>Donors get access to the special debug monitor, custom starting loadout, an extra bodyguard and the skins menu (... and other things as we dream them up)!</t>";		
	if (debugMonitor) then {
		debugMonitor = false;
		hintSilent "";
		hintSilent parseText _message;
		sleep 20;
		hintSilent "";	
		[] execvm "admintools\custom_monitor.sqf";	
	} else {
		hintSilent "";	
		hintSilent parseText _message;
		sleep 20;
		hintSilent "";		
	};
	sleep 900;

	_message = "<t size='1.2' color='#FFCC33' font='TahomaB'align='left'>Reminder: When the server is within 5 minutes of restart you should abort out of the game to ensure you do not lose equipment.</t>";
	if (debugMonitor) then {
		debugMonitor = false;
		hintSilent "";
		hintSilent parseText _message;
		sleep 12;
		hintSilent "";	
		[] execvm "admintools\custom_monitor.sqf";	
	} else {
		hintSilent "";	
		hintSilent parseText _message;
		sleep 12;
		hintSilent "";		
	};
	sleep 900;

	_message = "<t size='1.1' color='#FFCC33' font='TahomaB'align='left'>Donations can be made to help pay for server hosting fees at our website http://dayz.mvxhosting.com (Click on the PAYPAL Donate button on the left side of the page.)</t><br/><br/><t size='1.1' color='#FFFFFF' font='TahomaB'align='left'>Donors get access to the special debug monitor, custom starting loadout, an extra bodyguard and the skins menu (... and other things as we dream them up)!</t>";		
	if (debugMonitor) then {
		debugMonitor = false;
		hintSilent "";
		hintSilent parseText _message;
		sleep 20;
		hintSilent "";	
		[] execvm "admintools\custom_monitor.sqf";	
	} else {
		hintSilent "";	
		hintSilent parseText _message;
		sleep 20;
		hintSilent "";		
	};
	sleep 900;
	
};

