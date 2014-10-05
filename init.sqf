/*	
	For DayZ Epoch
	Addons Credits: Jetski Yanahui by Kol9yN, Zakat, Gerasimow9, YuraPetrov, zGuba, A.Karagod, IceBreakr, Sahbazz
*/
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	25;				//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//=BTC= Towing
_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";
_logistic = execVM "=BTC=_LogisticTow\=BTC=_Logistic_Init.sqf";

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// DayZ Epochconfig
spawnShoremode = 0; // Default = 1 (on shore)
spawnArea= 2000; // Default = 1500
// 
MaxVehicleLimit = 750; // Default = 50
MaxDynamicDebris = 500; // Default = 100
dayz_MapArea = 22000; // Default = 10000

dayz_minpos = -1000; 
dayz_maxpos = 26000;

dayz_paraSpawn = true;

dayz_sellDistance_vehicle = 10;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;
DZE_ForceNameTags = true;

DZE_teleport = [10000,200,500,10000,800];    //anti-teleport work around

dayz_maxAnimals = 5; // Default: 8
dayz_tameDogs = true;
DynamicVehicleDamageLow = 0; // Default: 0
DynamicVehicleDamageHigh = 100; // Default: 100

DZE_MissionLootTable = true;

DZE_BuildOnRoads = false; // Default: False

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];
dayz_fullMoonNights = true;

//Load in compiled functions
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
call compile preprocessFileLineNumbers "admintools\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "admintools\compiles.sqf";				//Compile regular functions
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
call compile preprocessFileLineNumbers "admintools\AdminList.sqf"; // Epoch admin Tools variables/UIDs
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	//Compile vehicle configs
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_25.sauerland\dynamic_vehicle.sqf";				
	// Add trader citys
//	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_25.sauerland\mission.sqf";

	//Add ACR @0 w/69
	_nil = [] execVM "mapedits\acr.sqf";

	//Add Bandit @100k w/59
	_nil = [] execVM "mapedits\bandit.sqf";

	//Add Black @200 w/40
	_nil = [] execVM "mapedits\black.sqf";

	//Add Oberdorf @300k w/58
	_nil = [] execVM "mapedits\klen.sqf";

	//Add Oberberg @400 w/153
	_nil = [] execVM "mapedits\oberberg.sqf";
	
	//Add Sedoef @600k w/86
	_nil = [] execVM "mapedits\sedorf.sqf";

	//Add South @700 w/58
	_nil = [] execVM "mapedits\south.sqf";

	//Add South @800 w/88
	_nil = [] execVM "mapedits\station.sqf";

	//Add WHO @900 w/147	
	_nil = [] execVM "mapedits\who.sqf";
	
	//Add Traders @XXX w/XXX	
	_nil = [] execVM "mapedits\traders.sqf";
	
	//Add North Wholesaler @1100 w/13	
	_nil = [] execVM "mapedits\north.sqf";
	
	//Add North Wholesaler @1200 w/41	
	_nil = [] execVM "mapedits\airfield.sqf";
	
	//Add Rest @1500 w/196	
	_nil = [] execVM "mapedits\rest.sqf";
	
	//Add Secret @1800 w/11	
	_nil = [] execVM "mapedits\secret.sqf";
	
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

// Epoch Admin Tools
[] execVM "admintools\Activate.sqf";

if (!isDedicated) then {
	//Refuel 
	[] execVM "Scripts\kh_actions.sqf";
	
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");

	//Custom Loadouts
	[] ExecVM "admintools\loadout.sqf";
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";	

	// Air Vehicle fix
//	_nil = [] execVM "Custom\specials.sqf";
	
	//Starting Air Vehicles action check
//	_nil = [] execVM "Custom\airvehiclefunctions.sqf";

	//Armored SUV Actions
//	_Armored_SUV_PMC_DZE_turret = [] execVM "Custom\VehicleActions\suvpmc_init.sqf";
	
	_nul = [] execVM "admintools\playerspawn.sqf";
	
	
	//anti Hack
	// Epoch Admin Tools
	if ( !((getPlayerUID player) in AdminList) && !((getPlayerUID player) in ModList)) then 
	{
		[] execVM "admintools\antihack\antihack.sqf"; // Epoch Antihack with bypass
	};

	//safezones
	[] execVM "Scripts\safezone.sqf";

	//safezones vehicles
	[] execVM "Scripts\safezonevehicle.sqf";

	//Service Point
	execVM "service_point\service_point.sqf";
	
	//Custom Debug
//	[] execvm "admintools\custom_monitor.sqf";	

	//Custom Debug Messages
	[] execvm "admintools\custom_messages.sqf";	
	
	//Lights
	[false,80] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
};
#include "\z\addons\dayz_code\system\REsec.sqf"
//Start Dynamic Weather
execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";

#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

// Heli Evac
//_nil = [] execVM "helievac\functions.sqf";
// Nox's Custom Action Menu
[] execVM "actions\activate.sqf";