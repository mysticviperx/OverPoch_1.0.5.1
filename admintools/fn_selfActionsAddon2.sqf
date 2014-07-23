/***********************************************************
	ADD-IN TO ACTIONS FOR SELF #2
************************************************************/

//----------------------------------------------------------------------------------
// Start Key Translation 
//----------------------------------------------------------------------------------
{player removeAction _x} forEach s_player_showowner;s_player_showowner = [];
_convertownerID = 0; 
_convertownerID = parseNumber _ownerID;						
if ((getPlayerUID player) in _admins || (getPlayerUID player) in _members || (getPlayerUID player) in _mods) then {
	_tempKeyName = Format["Unknown Key Number: %1",_ownerID];
	if((_convertownerID > 0) and (_convertownerID < 2501)) then {
		_tempKeyName = Format["ItemKeyGreen%1",_convertownerID];
	} else {
		if((_convertownerID > 2500) and (_convertownerID < 5001)) then {
			_tempKeyName = Format["ItemKeyRed%1",(_convertownerID - 2500)];		
		} else {
			if((_convertownerID > 5000) and (_convertownerID < 7501)) then {
				_tempKeyName = Format["ItemKeyBlue%1",(_convertownerID - 5000)];	
			} else {	
				if((_convertownerID > 7500) and (_convertownerID < 10001)) then {
					_tempKeyName = Format["ItemKeyYellow%1",(_convertownerID - 7500)];
				} else {	
					if((_convertownerID > 10000) and (_convertownerID < 12501)) then {
						_tempKeyName = Format["ItemKeyBlack%1",(_convertownerID - 10000)];
					};											
				};								
			};							
		};						
	};
} else {
	_tempKeyName = "";	
	if((_convertownerID > 0) and (_convertownerID < 2501)) then {
		_tempKeyName = "Uses Green Key";
	} else {
		if((_convertownerID > 2500) and (_convertownerID < 5001)) then {
			_tempKeyName = "Uses Red Key";
		} else {
			if((_convertownerID > 5000) and (_convertownerID < 7501)) then {
				_tempKeyName = "Uses Blue Key";
			} else {	
				if((_convertownerID > 7500) and (_convertownerID < 10001)) then {
					_tempKeyName = "Uses Yellow Key";
				} else {	
					if((_convertownerID > 10000) and (_convertownerID < 12501)) then {
						_tempKeyName = "Uses Black Key";
					};											
				};								
			};							
		};						
	};						
};




	
if ((getPlayerUID player) in _admins) then {
	//_vehicle setVariable ["KeyName", _tempKeyName];
	s_keyname = _tempKeyName;
	_showowner = player addAction [format["<t color='#6699ff'>Make Key: %1</t>", _tempKeyName], "admintools\weaponkits\MakeKey.sqf",_cursorTarget, 3, false, true, "", ""];						
	s_player_showowner set [count s_player_showowner,_showowner];
} else {
	if ((getPlayerUID player) in _members || (getPlayerUID player) in _mods) then {
		_showowner = player addAction [format["<t color='#6699ff'>Key Name: %1</t>", _tempKeyName], "",_cursorTarget, 0, false, true, "", ""];
		s_player_showowner set [count s_player_showowner,_showowner];
	} else {
		_showowner = player addAction [format["<t color='#6699ff'>Key Name: %1</t>", _tempKeyName], "",_cursorTarget, 0, false, true, "", ""];
		s_player_showowner set [count s_player_showowner,_showowner];
	};
};

//----------------------------------------------------------------------------------					
// End Key Translation 
//----------------------------------------------------------------------------------
