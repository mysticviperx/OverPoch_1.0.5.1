/***********************************************************
	ADD-IN TO ACTIONS FOR SELF #3
************************************************************/

//----------------------------------------------------------------------------------
// Start Safe Code Lookup 
if (isNil ("s_player_showcode")) then {
	s_player_showcode = -1;
};

if ((getPlayerUID player) in _admins) then {
	if (s_player_showcode < 0) then {
		s_player_showcode = player addaction [format["<t color='#6699ff'>Safe Code: %1</t>", _ownerID], "",_cursorTarget, 0, false, true, "", ""];	
	};
};
// Stop Safe Code Lookup 
//----------------------------------------------------------------------------------
