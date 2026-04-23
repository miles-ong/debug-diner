if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

// --- Setup ---
debugLabel = "[GameController]";
levels = [];

#region Regions
#region North America
northAmericaLevels = [
	CreateLevel(
		"Level 1-1", 
		spr_TrophyBurger, 
		true, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level1_1,
		undefined,
		//[ BlockType.MOVE ],
		undefined,
		#region Level 1-1 Event
		[
			EventAction(EventSignal.LEVELSTARTED, new Dialogue("Agh!!!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Uh...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Who are you?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I knew that maneuver would be too ti-", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Say that again?", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I said, who are y-", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Oh thank the mothership!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I thought I missed Terra by a solar system!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Terra? Wait hold on, answer my questions!", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Who are you? And more importantly...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("WHAT ARE YOU DOING IN MY BACKYARD?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Hmmm...", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Give me a moment...", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("AHA! It is English you speak, correct?", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Obviously? Are you ever going to answ-", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Terran! You are now the head chef for Debug Diner!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("This feels like a one-sided conversation.", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("What is Debug Diner you asked?", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("It will be a planet famous diner, capable of delighting even the toughest of critics and the pickiest of eaters!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("And you will provide and cook the world's greatest recipes in this beautiful UFO!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("So you only answer my questions when you make them up for yourself?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Also, my cooking knowledge goes as far as cup ramen, so I am most certainly not your... 'Terran'.", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I see... that is truly a shame... if only there was a solution...", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("AHA! There is!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("You will become my head programmer!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Your what?", spr_Player, Position.LEFT, DialogueColor.BLUE)),	
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("My head programmer!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("We're understaffed, so we'll have to repurpose these transporter robots into waiters!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Go get a closer look at that one over there, you might have to poke it to wake it up...", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Highlight(obj_Waiter)),
			EventAction(EventSignal.OBJECTCLICKED, [new Dialogue("Behold!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE), new Custom(function() {
					var panelX = obj_ProgrammingPanel.x;
					var panelY = obj_ProgrammingPanel.y;
					var panelW = obj_ProgrammingPanel.sprite_width;
					var panelH = obj_ProgrammingPanel.sprite_height;
					instance_create_layer(panelX + panelW * 0.5, panelY + panelH * 0.5, "Event", obj_PanelCover);
				})], obj_Waiter),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("The waiter!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("What am I supposed to be looking at?", spr_Player, Position.LEFT, DialogueColor.BLUE)),	
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("The programming pa-", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("You need to open the door first.", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE, 4, fo_UIMedium)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Highlight(obj_PanelCover)),
			EventAction(EventSignal.OBJECTCLICKED, [new Dialogue("Well done Terran! See that 'Program' block up there?", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE), new Highlight(obj_Block)], obj_PanelCover),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("That's the heart of this operation!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Try connecting a 'Move' block to it, you should hear a click when the blocks link!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I don't remember signing up for this.", spr_Player, Position.LEFT, DialogueColor.BLUE)),	
			EventAction(EventSignal.DIALOGUEFINISHED, new Unhighlight(obj_Block)),
			EventAction(EventSignal.BLOCKCONNECTED, new Dialogue("Ahhh, that sound is always so satisfying.", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("It was pretty nice, I'll give you that...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("But if the diner gets busy, wouldn't it get a little hard to hear?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Don't worry about that!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("See the lights on the blocks?", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("If it's lit up green, it's connected. If it's red, it's disconnected!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("What if it's not lit up, like the 'Program' block?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Ah! That just means you can't move it like the other blocks!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Why exactly?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Because the laws of the universe said so!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("What did they specifically say...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("42.", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("What?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("42.", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Forget it, what do I do now?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, [new Dialogue("Let's see if you can guide the waiter to that table!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE), new Highlight(obj_Table)]),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Good service is of utmost importance!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Unhighlight(obj_Table))
		]
		#endregion
	),
	CreateLevel(
		"Level 1-2",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE),
		CreateTask(TaskType.USEBLOCK, BlockType.TURN),
		undefined,
		rm_Level1_2,
		undefined,
		[ BlockType.MOVE, BlockType.TURN ],
		#region Level 1-2 Event
		[
			EventAction(EventSignal.LEVELSTARTED, new Dialogue("I knew you had it in you Terran!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Thanks...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Are you ever going to tell me your name?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("My name?", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Ah! You must be referring to my 'title'!", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("The cosmos knows me as...", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue(">-&<+*%&@>#-+!-", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE, 10, fo_UIMega)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Speak English please.", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("How about I teach you my langu-", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("English.", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Ugh, fine.", spr_AlienSilhouette, Position.RIGHT, DialogueColor.WHITE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("You can call me 'Alien'!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("How creative.", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Enough small talk!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, [new Dialogue("See that window to your right?", spr_Alien, Position.RIGHT, DialogueColor.GREEN), new Highlight(obj_UILevelTasks)]),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I'd get tired having to tell you what to do all the time...", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("So instead, I will have the UFO tell you for me!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Aren't you telling the UFO what to tell me...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Anyways, the tasks marked white MUST be completed!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("The yellow ones are for your bonus!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("My bonus? Does this mean you're paying me?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Pay? What are you talking about?", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Aren't you humans obsessed with being completionists?", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("This is a game afterall!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("We don't normally break the 4th wall this early.", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Unhighlight(obj_UILevelTasks)),
		]
		#endregion
	),
	CreateLevel(
		"Level 1-3",
		spr_TrophyBurger,
		false,
		CreateTask(TaskType.GUIDETOTABLE),
		CreateTask(TaskType.USEBLOCK, BlockType.LOOP),
		CreateTask(TaskType.LESSTHANBLOCKS, 3),
		rm_Level1_3,
		undefined,
		[ BlockType.MOVE, BlockType.LOOP ],
		#region Level 1-3 Event
		[
			EventAction(EventSignal.LEVELSTARTED, new Dialogue("Welcome back to the most famous restaurant on this planet!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Famous? You're still parked in my backyard...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("But can't you see our future together head programmer!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Ugh, can you NOT call me that!", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("...", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Fine.", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Anyways, I finished repairing the UFO, so all we need now is for you to complete your training!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("I've been training?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Of course! I need to make sure my head progr- I mean, 'partner' is prepared to start this journey!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Here is the final test!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Why don't you give that 'Loop' block a spin!", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("Couldn't I just use the 'Move' blocks like I did before?", spr_Player, Position.LEFT, DialogueColor.BLUE)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("You could, but being efficient will lead to good service...", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("And good service is?", spr_Alien, Position.RIGHT, DialogueColor.GREEN)),
			EventAction(EventSignal.DIALOGUEFINISHED, new Dialogue("\"Of utmost importance\"...", spr_Player, Position.LEFT, DialogueColor.BLUE)),
		]
		#endregion
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
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP],
		#region Level 1-4 Event
		[
			
		]
		#endregion
	)
];
#endregion
#region South America
southAmericaLevels = [
	CreateLevel(
		"Level 2-1", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level2_1,
		undefined,
		[ BlockType.MOVE, BlockType.LOOP],
		undefined
	),
	CreateLevel(
		"Level 2-2", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level2_2,
		undefined,
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP, BlockType.WAIT ],
		undefined
	),
	CreateLevel(
		"Level 2-3", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level2_3,
		undefined,
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP, BlockType.WAIT ],
		undefined
	),
];
#endregion
#region Africa
africaLevels = [
	CreateLevel(
		"Level 3-1", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		CreateTask(TaskType.USEBLOCK, BlockType.IF), 
		CreateTask(TaskType.LESSTHANBLOCKS, 4), 
		rm_Level3_1,
		undefined,
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP, BlockType.IF, BlockType.COND_AHEAD_IS],
		undefined
	),
	CreateLevel(
		"Level 3-2", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		CreateTask(TaskType.LESSTHANBLOCKS, 5), 
		CreateTask(TaskType.USEBLOCK, BlockType.IF), 
		rm_Level3_2,
		undefined,
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP, BlockType.IF, BlockType.COND_AHEAD_IS],
		undefined
	),
	CreateLevel(
		"Level 3-3", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		CreateTask(TaskType.LESSTHANBLOCKS, 6), 
		undefined,
		rm_Level3_3,
		undefined,
		[ BlockType.MOVE, BlockType.TURN, BlockType.LOOP, BlockType.IF, BlockType.COND_AHEAD_IS],
		undefined
	),
];
#endregion
#region Europe
europeLevels = [
	CreateLevel(
		"Level 4-1", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level1_1,
		undefined,
		undefined,
		undefined
	),
];
#endregion
#region Asia
asiaLevels = [
	CreateLevel(
		"Level 5-1", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level1_1,
		undefined,
		undefined,
		undefined
	),
];
#endregion
#region Australia
australiaLevels = [
	CreateLevel(
		"Level 6-1", 
		spr_TrophyBurger, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level1_1,
		undefined,
		undefined,
		undefined
	),
];
#endregion
#endregion

// --- Tracking ---
currLevelIdx = 0;

continueRegion = LevelRegion.NORTHAMERICA;
continueLevelIdx = 0;

function GetRegionLevels(_region) {
	switch(_region) {
		case LevelRegion.NORTHAMERICA: return northAmericaLevels;
		case LevelRegion.SOUTHAMERICA: return southAmericaLevels;
		case LevelRegion.AFRICA: return africaLevels;
		case LevelRegion.EUROPE: return europeLevels;
		case LevelRegion.ASIA: return asiaLevels;
		case LevelRegion.AUSTRALIA: return australiaLevels;
	}
}

function GetNextRegion(_region) {
	switch(_region) {
		case LevelRegion.NORTHAMERICA: return LevelRegion.SOUTHAMERICA;
		case LevelRegion.SOUTHAMERICA: return LevelRegion.AFRICA;
		case LevelRegion.AFRICA: return LevelRegion.EUROPE;
		case LevelRegion.EUROPE: return LevelRegion.ASIA;
		case LevelRegion.ASIA: return LevelRegion.AUSTRALIA;
		case LevelRegion.AUSTRALIA: return undefined;
	}
}

/// @description Fills the available levels with the levels from the given region
/// @param _region The region to load levels from
/// @param _index The current level index to set to. Defaults to 0
function SetRegionLevels(_region, _index = 0) {
	var regionLevels = GetRegionLevels(_region);
	
	if(_index >= array_length(regionLevels)) return;
	
	levels = regionLevels;
	global.currentRegion = _region;
	currLevelIdx = _index;
}

/// @description Gets the level from levels using a given index
/// @param _index The index to access
function GetLevel(_index) {
	if(_index < 0 || _index > array_length(levels) - 1) return undefined;
	
	return levels[_index];
}

/// @description Gets the next level's index. If at the end, wraps to the beginning of the list
function GetNextLevelIndex() {
	var length = array_length(levels);
	
	if(length <= 0) return 0;
	
	return (currLevelIdx + 1) % length;
}

/// @description Gets the previous level's index. If at the beginning, wraps to the end of list
function GetPrevLevelIndex() {
	var length = array_length(levels);
	
	if(length <= 0) return 0;
	
	return (currLevelIdx - 1 + length) % length; 
}

/// @description Sets the current level to a given index
/// @param _index The index to access
function SetCurrentLevel(_index) {
	var level = GetLevel(_index);
	
	if(level != undefined) {
		currLevelIdx = _index;
		global.currentLevel = level;
		show_debug_message($"{debugLabel} Set current level to '{level.name}'");
	}
}

/// @description Loads a level from levels using a given index and enters the level's room
/// @param _index The index to access
function GoToLevel(_index) {
	if(_index < 0 || _index > array_length(levels) - 1) return;
	
	var level = { 
		targetRoom : levels[_index].targetRoom,
		index : _index
	};
	
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
		obj_GameController.SetCurrentLevel(index);
	})));
}

/// @description Goes to the currently selected level
function GoToCurrentLevel() {
	GoToLevel(currLevelIdx);
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
		obj_GameController.SetCurrentLevel(0);
	}));
}

/// @description Clears all instances from potentially persistent layers
function ClearLayers() {
	layer_destroy_instances("MenuBlock");
	layer_destroy_instances("MenuBlockDragging");
	layer_destroy_instances("BlockSlot");
	layer_destroy_instances("Block");
	layer_destroy_instances("ConditionalBlock");
	layer_destroy_instances("ConditionalSlot");
	layer_destroy_instances("BlockContent");
	layer_destroy_instances("BlockSlotDragging");
	layer_destroy_instances("BlockDragging");
	layer_destroy_instances("ConditionalBlockDragging");
	layer_destroy_instances("ConditionalSlotDragging");
	layer_destroy_instances("BlockContentDragging");
}

function UnlockAllLevels() {	
	for(var i = 0; i < LevelRegion.AUSTRALIA + 1; i++) {
		SetRegionLevels(i);
		
		for(var j = 0; j < array_length(levels); j++) {
			levels[j].unlocked = true;
		}
	}
	
	SetRegionLevels(LevelRegion.NORTHAMERICA);
	show_debug_message($"{debugLabel} Unlocked all levels");
}