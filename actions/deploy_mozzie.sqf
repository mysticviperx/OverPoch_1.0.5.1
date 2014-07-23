private ["_mags","_scrapNumber","_canDo","_onLadder","_finished","_finishedTime","_veh","_location","_vehtospawn","_dir","_pos","_dist","_location","_worldspace","_charID"];

_mags = magazines player;
_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder && !_inVehicle);
_scrapNumber = {_x == "PartGeneric";} count _mags; // must return 2 or more

if(_scrapNumber > 1 && "PartEngine" in _mags && "ItemJerrycan" in _mags && "PartVRotor" in _mags) then {
	hasMozzieItem = true;
} else { 
	hasMozzieItem = false;
	cutText ["\n\nNeed: 2x Scrap Metal, 1x Engine, 1x VRotor, and 1x Jerrycan required to build mozzie", "PLAIN DOWN"];
};

if (hasMozzieItem && _canDo && dayz_combat == 1) then {
    cutText ["You are in Combat and cannot build a Mozzie.", "PLAIN DOWN"];
};

if (hasMozzieItem && _canDo && (dayz_combat !=1)) then {
	DZE_ActionInProgress = true;
	player removeMagazine "PartGeneric";
	player removeMagazine "PartGeneric";
	player removeMagazine "PartEngine";
	player removeMagazine "ItemJerrycan";
	player removeMagazine "PartVRotor";

	player playActionNow "Medic";
	[player,"repair",0,false,10] call dayz_zombieSpeak;
	[player,10,true,(getPosATL player)] spawn player_alertZombies;

	r_interrupt = false;
	r_doLoop = true;

	_finished = false;
	_finishedTime = diag_tickTime+10;

	while {r_doLoop} do {
		if (diag_tickTime >= _finishedTime) then {
			r_doLoop = false;
			_finished = true;
		};
		if (r_interrupt) then {
			r_doLoop = false;
		};
		sleep 0.1;
	};

	if (_finished) then {
		_vehtospawn = "CSJ_GyroC";
		_dist = 8;
		_charID = dayz_characterID;
		_dir = getDir vehicle player;
		_pos = getPosATL vehicle player;
		_pos = [(_pos select 0)+_dist * sin(_dir),(_pos select 1)+ _dist * cos(_dir),0];
		_worldspace = [_dir,_pos];
		_location = _pos; 
		_veh = createVehicle [_vehtospawn, _pos, [], 0, "CAN_COLLIDE"];
		_veh setVariable ["MalSar",1,true];
		clearMagazineCargoGlobal _veh;
		clearWeaponCargoGlobal _veh;
		_veh setVehicleAmmo 0;

		cutText ["You've built a Mozzie!", "PLAIN DOWN"];
		DZE_ActionInProgress = false;
		sleep 10;
		cutText ["Warning: Spawned Mozzies DO NOT SAVE after server restart!", "PLAIN DOWN"];
	} else {
		r_interrupt = false;
		player switchMove "";
		player playActionNow "stop";
		player addMagazine "PartGeneric";
		player addMagazine "PartGeneric";
		player addMagazine "PartEngine";
		player addMagazine "ItemJerrycan";
		player addMagazine "PartVRotor";
		DZE_ActionInProgress = false;
		cutText ["\n\nCanceled building a Mozzie.", "PLAIN DOWN"];
	};
} else {
	if(!_canDo) then {
		cutText ["You are in a vehicle or already performing an action","PLAIN DOWN"];
	};
};