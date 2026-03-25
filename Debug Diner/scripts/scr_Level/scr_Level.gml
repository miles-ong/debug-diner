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
	NORTHAMERICA,
	SOUTHAMERICA,
	EUROPE,
	ASIA,
	AFRICA,
	AUSTRALIA
}

function CreateLevel(n, t, u, mt, bt1, bt2, tr, c = undefined) {
	return {
		name : n,
		trophy : t,
		unlocked : u,
		mainTask : mt,
		bonusTask1 : bt1,
		bonusTask2 : bt2,
		targetRoom : tr,
		customers : c
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