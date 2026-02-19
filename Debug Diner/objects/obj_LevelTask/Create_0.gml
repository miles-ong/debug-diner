type = TaskType.LESSTHANBLOCKS;
threshold = 0;
description = "";
isCompleted = false;

persistent = true;

function SetupType() {
	switch(type) {
		case TaskType.LESSTHANBLOCKS:
			description = "Complete using fewer than " + string(threshold) + " blocks.";
			break;
	}
}

// WORKINPROGRESS