private ["_baserunover","_crate_type","_crate","_mission","_position","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Ural Attack]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_medium call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0) - 10,(_position select 1) - 10,0],[],10,"FORM"];
_crate call wai_crate_setup;

//Base
_baserunover = createVehicle ["UralWreck",[(_position select 0),(_position select 1),0],[],14,"FORM"];
_baserunover setVectorUp surfaceNormal position _baserunover;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Easy",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Ural Attack", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_CL_BANDIT_URAL_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_URAL_WIN", // mission success
	"STR_CL_BANDIT_URAL_FAIL", // mission fail
	[4,8,36,3,2] // Dynamic crate array
] call mission_winorfail;