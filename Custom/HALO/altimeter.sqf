sleep 5;
_myalt = getPos player select 2;
_myalt = round(_myalt);
//debug start
diag_log(format["ALTIMETER STARTED: %1m ", _myalt]);
 
while {(_myalt) > 0} do {
 
// Display my altitude text.
_myalt = getPos player select 2;
_myalt = round(_myalt);
 
titleText [("                                      ALTITUDE: " + str _myalt + "\n\n                                      Scroll ""mouse"" select Open Chute"), "PLAIN DOWN", 0.1];
 
};
//debug Stop
diag_log(format["ALTIMETER STOPPED: %1m ", _myalt]);