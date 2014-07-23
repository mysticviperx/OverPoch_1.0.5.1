private["_veh", "_idx"];
Sleep 15;	
_idx = -1;

while {alive player} do {
	if(_idx == -1) then {
		_idx = (vehicle player) addaction [("<t color=""#FE9A2E"">" + ("Action Menu") + "</t>"),"actions\Actions_Menu.sqf","",6,false,true,"",""];
		_veh = vehicle player;
	};
	if (_veh != vehicle player) then
	{
		_veh removeAction _idx;
		_idx = -1;      
	};
	Sleep 2;
};