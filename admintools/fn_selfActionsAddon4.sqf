
if (isNil ("s_player_butcher_human")) then {
	s_player_butcher_human = -1;
};
	
//####    Gut fools ####
_hasHarvested = _cursorTarget getVariable["meatHarvested",false];

if (!_isAlive and !_isZombie and !_isAnimal and !_isHarvested and _isMan and _hasKnife and _canDo and !_hasHarvested) then {
	if (s_player_butcher_human < 0) then {
		s_player_butcher_human = player addAction [format["<t color='#42426F'>Gut Human</t>"], "Scripts\gather_meat_human.sqf",_cursorTarget, 3, false, true, "", ""];
	};
} else {
	player removeAction s_player_butcher_human;
	s_player_butcher_human = -1;
};
