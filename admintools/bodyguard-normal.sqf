#include "AdminTools-AccessList.sqf"
call compile preprocessFileLineNumbers ("admintools\ac_functions.sqf");

// Load consist of [ "Weaponclass", "Ammoclass", #ofmags, [ "array of bandit skins" ], [ "array of neutral skins" ], [ "array of hero skins"] ],


BG_Weapon_Loadouts = [

    ["M4A3_CCO_EP1", "30Rnd_556x45_Stanag", 12,["Bandit1_DZ","Bandit2_DZ","BanditW1_DZ","BanditW2_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"],["Priest_DZ","Functionary1_EP1_DZ","Drake_Light_DZ","TK_INS_Warlord_EP1_DZ","TK_INS_Soldier_EP1_DZ","Graves_Light_DZ","Ins_Soldier_GL_DZ","Haris_Press_EP1_DZ","Pilot_EP1_DZ","RU_Policeman_DZ"],["GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Soldier_Crew_PMC","Survivor2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWpink_DZ","SurvivorW3_DZ","SurvivorW2_DZ","CZ_Special_Forces_GL_DES_EP1_DZ"]], 
    ["M4A1_HWS_GL", "30Rnd_556x45_Stanag", 12,["Bandit1_DZ","Bandit2_DZ","BanditW1_DZ","BanditW2_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"],["Priest_DZ","Functionary1_EP1_DZ","Drake_Light_DZ","TK_INS_Warlord_EP1_DZ","TK_INS_Soldier_EP1_DZ","Graves_Light_DZ","Ins_Soldier_GL_DZ","Haris_Press_EP1_DZ","Pilot_EP1_DZ","RU_Policeman_DZ"],["GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Soldier_Crew_PMC","Survivor2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWpink_DZ","SurvivorW3_DZ","SurvivorW2_DZ","CZ_Special_Forces_GL_DES_EP1_DZ"]],
    ["M4A1_Aim", "30Rnd_556x45_Stanag", 12,["Bandit1_DZ","Bandit2_DZ","BanditW1_DZ","BanditW2_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"],["Priest_DZ","Functionary1_EP1_DZ","Drake_Light_DZ","TK_INS_Warlord_EP1_DZ","TK_INS_Soldier_EP1_DZ","Graves_Light_DZ","Ins_Soldier_GL_DZ","Haris_Press_EP1_DZ","Pilot_EP1_DZ","RU_Policeman_DZ"],["GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Soldier_Crew_PMC","Survivor2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWpink_DZ","SurvivorW3_DZ","SurvivorW2_DZ","CZ_Special_Forces_GL_DES_EP1_DZ"]],
    ["m8_Carbine", "30Rnd_556x45_Stanag", 12,["Bandit1_DZ","Bandit2_DZ","BanditW1_DZ","BanditW2_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"],["Priest_DZ","Functionary1_EP1_DZ","Drake_Light_DZ","TK_INS_Warlord_EP1_DZ","TK_INS_Soldier_EP1_DZ","Graves_Light_DZ","Ins_Soldier_GL_DZ","Haris_Press_EP1_DZ","Pilot_EP1_DZ","RU_Policeman_DZ"],["GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Soldier_Crew_PMC","Survivor2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWpink_DZ","SurvivorW3_DZ","SurvivorW2_DZ","CZ_Special_Forces_GL_DES_EP1_DZ"]],
    ["SVD_CAMO", "10Rnd_762x54_SVD", 12,["CZ_Soldier_Sniper_EP1_DZ","GUE_Soldier_Sniper_DZ","Sniper1_DZ","Soldier_Sniper_PMC_DZ"],["CZ_Soldier_Sniper_EP1_DZ","GUE_Soldier_Sniper_DZ","Sniper1_DZ","Soldier_Sniper_PMC_DZ"],["CZ_Soldier_Sniper_EP1_DZ","GUE_Soldier_Sniper_DZ","Sniper1_DZ","Soldier_Sniper_PMC_DZ"]],
    ["DMR", "20Rnd_762x51_DMR", 12,["CZ_Soldier_Sniper_EP1_DZ","GUE_Soldier_Sniper_DZ","Sniper1_DZ","Soldier_Sniper_PMC_DZ"],["CZ_Soldier_Sniper_EP1_DZ","GUE_Soldier_Sniper_DZ","Sniper1_DZ","Soldier_Sniper_PMC_DZ"],["CZ_Soldier_Sniper_EP1_DZ","GUE_Soldier_Sniper_DZ","Sniper1_DZ","Soldier_Sniper_PMC_DZ"]],
    ["Mk_48", "100Rnd_762x51_M240", 6,["Bandit1_DZ","Bandit2_DZ","BanditW1_DZ","BanditW2_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"],["Priest_DZ","Functionary1_EP1_DZ","Drake_Light_DZ","TK_INS_Warlord_EP1_DZ","TK_INS_Soldier_EP1_DZ","Graves_Light_DZ","Ins_Soldier_GL_DZ","Haris_Press_EP1_DZ","Pilot_EP1_DZ","RU_Policeman_DZ"],["GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Soldier_Crew_PMC","Survivor2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWpink_DZ","SurvivorW3_DZ","SurvivorW2_DZ","CZ_Special_Forces_GL_DES_EP1_DZ"]]

];

_useHALO = _this select 0;

_cost = ["ItemGoldBar",1];

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#include "bodyguard-main.sqf"
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
