if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

// --- Setup ---
debugLabel = "[obj_GameController]";
levels = [];

#region Levels
northAmericaLevels = [
	CreateLevel(
		"Level 1-1", 
		spr_TrophyBurger, 
		true, 
		CreateTask(TaskType.LESSTHANBLOCKS, 4), 
		undefined, 
		undefined, 
		rm_Level1_1,
		undefined,
		undefined
	),
	CreateLevel(
		"Level 1-2",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE),
		undefined,
		undefined,
		rm_Level1_2,
		undefined,
		[ BlockType.MOVE, BlockType.TURN ]
	),
	CreateLevel(
		"Level 1-3",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE),
		CreateTask(TaskType.USEBLOCK, BlockType.TURN),
		undefined,
		rm_Level1_3,
		undefined,
		[ BlockType.MOVE, BlockType.TURN ]
	),
	CreateLevel(
		"Level 1-4",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE),
		CreateTask(TaskType.USEBLOCK, BlockType.LOOP),
		CreateTask(TaskType.LESSTHANBLOCKS, 5),
		rm_Level1_4,
		undefined,
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP ]
	),
	CreateLevel(
		"Level 1-5",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE, 2),
		undefined,
		undefined,
		rm_Level1_5,
		undefined,
		undefined
	),
	CreateLevel(
		"Level 1-6",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE, 2),
		undefined,
		undefined,
		rm_Level1_6,
		undefined,
		undefined
	),
	CreateLevel(
		"Level 1-7",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE, 2),
		undefined,
		undefined,
		rm_Level1_7,
		undefined,
		undefined
	),
	CreateLevel(
		"Level 1-8",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE, 2),
		undefined,
		undefined,
		rm_Level1_8,
		undefined,
		undefined
	),
];
#endregion
#region Regions
southAmericaLevels = [];
europeLevels = [];
asiaLevels = [];
africaLevels = [];
australiaLevels = [];
#endregion

// --- Tracking ---
currentRegion = LevelRegion.NORTHAMERICA;
currentLevelIndex = 0;
continueLevel = 0;

/// @description Fills the available levels with the levels from the given region
/// @param _region The region to load levels from
function SetLevelRegion(_region) {
	levels = [];
	
	switch(_region) {
		case LevelRegion.NORTHAMERICA: levels = northAmericaLevels; break;
		case LevelRegion.SOUTHAMERICA: levels = southAmericaLevels; break;
		case LevelRegion.EUROPE: levels = europeLevels; break;
		case LevelRegion.ASIA: levels = asiaLevels; break;
		case LevelRegion.AFRICA: levels = africaLevels; break;
		case LevelRegion.AUSTRALIA: levels = australiaLevels; break;
	}
}

/// @description Sets the current level to a level from levels using a given index. If the index is out of bounds, the current level doesn't change
/// @param _index The index to access
function SetCurrentLevel(_index) {
	if(_index < 0 || _index > array_length(levels) - 1) return;
	
	currentLevelIndex = _index;
	global.currentLevel = levels[_index];
}

/// @description Gets the level from levels using a given index
/// @param _index The index to access
function GetLevel(_index) {
	if(_index < 0 || _index > array_length(levels) - 1) return noone;
	
	return levels[_index];
}

/// @description Gets the next level's index. If the index goes out of bounds, wrap back to the first level in levels
function GetNextLevelIndex() {
	var length = array_length(levels);
	
	if(length == 0) return undefined;
	
	return (currentLevelIndex + 1) % array_length(levels);
}

/// @description Gets the previous level's index. If the index goes out of bounds, wrap back to the last level in levels
function GetPreviousLevelIndex() {
	var length = array_length(levels)
	
	if(length == 0) return undefined;
	
	return (currentLevelIndex - 1 + length) % array_length(levels);
}

/// @description Loads a level from levels using a given index and enters the level's room
/// @param The index to access
function GoToLevel(index) {
	if(index < 0 || index > array_length(levels) - 1) return;
	
	var level = { targetRoom : levels[index].targetRoom };
	ChangeGameState(GameState.TRANSITIONING);
	
	obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, true, method(level, function() {
		room_goto(targetRoom);
		obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, false, function() {
			obj_LevelController.StartLevel();
		}));
		layer_set_visible("GameStartInterface", false);
		layer_set_visible("LevelSelectInterface", false);
		layer_set_visible("LevelResult", false);
		layer_set_visible("MainMenuInterface", false);
		layer_set_visible("LevelInterface", true);
	})));
}

/// @description Goes to the currently selected level
function GoToCurrentLevel() {
	GoToLevel(currentLevelIndex);
}

/// @description Goes back to the main menu room
function ReturnToMainMenu() {
	ChangeGameState(GameState.TRANSITIONING);
	
	obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, true, function() {
		room_goto(rm_MainMenu);
		obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, false, function() {
			ChangeGameState(GameState.MENUS);
		}));
		layer_set_visible("GameStartInterface", false);
		layer_set_visible("LevelInterface", false);
		layer_set_visible("LevelResult", false);
		layer_set_visible("MainMenuInterface", true);
	}));
}

/// @description Clears all instances from potentially persistent layers
function ClearLayers() {
	layer_destroy_instances("MenuBlock");
	layer_destroy_instances("MenuBlockDragging");
	layer_destroy_instances("BlockSlot");
	layer_destroy_instances("Block");
	layer_destroy_instances("BlockContent");
	layer_destroy_instances("BlockSlotDragging");
	layer_destroy_instances("BlockDragging");
	layer_destroy_instances("BlockContentDragging");
}

SetLevelRegion(LevelRegion.NORTHAMERICA);
SetCurrentLevel(0);