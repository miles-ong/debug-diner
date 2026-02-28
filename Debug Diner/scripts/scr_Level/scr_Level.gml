function CreateLevel(n, t, u, mt, bt1, bt2, tr) {
	return {
		name : n,
		trophy : t,
		unlocked : u,
		mainTask : mt,
		bonusTask1 : bt1,
		bonusTask2 : bt2,
		targetRoom : tr
	};
}

function CreateTask(taskType, threshold = 1) {
	switch(taskType) {
		case TaskType.GUIDETOTABLE: 
			return {
				type : taskType,
				isCompleted : false,
				description : "Guide waiters such that each table has at least " + string(threshold) + " facing it.",
				waitersPerTable : threshold
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
				description : "Use fewer than " + string(threshold) + " blocks.",
				blocks : threshold
			};
	}
}