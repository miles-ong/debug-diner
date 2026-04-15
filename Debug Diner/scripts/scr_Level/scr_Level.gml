enum TaskType {
	GUIDETOTABLE,
	COMPLETEORDERS,
	COMPLETEBONUSORDERS,
	LESSTHANBLOCKS,
	USEBLOCK,
	NOTUSEBLOCK
}

enum TrophySprite {
	EMPTY = 0,
	BRONZE = 1,
	SILVER = 2,
	GOLD = 3
}

enum LevelRegion {
	NORTHAMERICA = 0,
	SOUTHAMERICA = 1,
	AFRICA = 2,
	EUROPE = 3,
	ASIA = 4,
	AUSTRALIA = 5
}

/// @description Constructs level data
/// @param _name Name of the level
/// @param _trophy Trophy sprite
/// @param _unlocked Determines whether the level is unlocked or not
/// @param _mainTask Main task to complete level
/// @param _bonusTask1 Bonus task, mark undefined if nothing
/// @param _bonusTask2 Bonus task, mark undefined if nothing
/// @param _trophy Room to enter
/// @param _customers Customers to serve
/// @param _enabledBlocks Array of blocks that are enabled, mark undefined if no blocks are disabled
/// @param _event The event to be executed at the start of the level
function CreateLevel(_name, _trophy, _unlocked, _mainTask, _bonusTask1, _bonusTask2, _targetRoom, _customers = undefined, _enabledBlocks = undefined, _event = undefined) {
	return {
		name : _name,
		trophy : _trophy,
		unlocked : _unlocked,
		mainTask : _mainTask,
		bonusTask1 : _bonusTask1,
		bonusTask2 : _bonusTask2,
		targetRoom : _targetRoom,
		customers : _customers,
		enabledBlocks : _enabledBlocks,
		eventSequence : _event,
		eventCompleted : false
	};
}

function CreateTask(taskType, param = 1) {
	switch(taskType) {
		case TaskType.GUIDETOTABLE: 
			return {
				type : taskType,
				isCompleted : false,
				description : "Guide waiters such that each table has at least " + string(param) + " facing it.",
				waitersPerTable : param
			};
			
		case TaskType.COMPLETEORDERS:
			return {
				type : taskType,
				isCompleted : false,
				description : "Complete all required orders."
			};
			
		case TaskType.COMPLETEBONUSORDERS:
			return {
				type : taskType,
				isCompleted : false,
				description : "Complete all bonus orders."
			};
			
		case TaskType.LESSTHANBLOCKS:
			return {
				type : taskType,
				isCompleted : false,
				description : "Use fewer than " + string(param) + " blocks.",
				blocks : param
			};
			
		case TaskType.USEBLOCK:
			return {
				type : taskType,
				isCompleted : false,
				description : "Use a " + BlockTypeToString(param) + " block.",
				block : param
			};
			
		case TaskType.NOTUSEBLOCK:
			return {
				type : taskType,
				isCompleted : false,
				description : "Do not use a " + BlockTypeToString(param) + " block.",
				block : param
			};
	}
}