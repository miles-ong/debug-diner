type = TaskType.LESSTHANBLOCKS;
threshold = 0;
description = "";
isCompleted = false;

function Initialize() {
	switch(type) {
		case TaskType.GUIDETOTABLE:
			description = "Guide waiters such that each table has at least one facing it.";
			break;
			
		case TaskType.COMPLETEORDERS:
			description = "Complete all required orders."
			break;
			
		case TaskType.COMPLETEBONUSORDERS:
			description = "Complete all bonus orders."
			break;
			
		case TaskType.LESSTHANBLOCKS:
			description = "Use fewer than " + string(threshold) + " blocks.";
			break;
	}
}