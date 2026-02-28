if(instance_exists(obj_LevelController) > 1) {
	instance_destroy();
	return;
}

totalBlocksUsed = 0;

mainTask = undefined;
bonusTask1 = undefined;
bonusTask2 = undefined;

prevBonusTask1Completion = false;
prevBonusTask2Completion = false;

function StartLevel() {
	totalBlocksUsed = 0;
	
	var currLevel = global.currentLevel;
	
	if(currLevel == noone) return;
	
	mainTask = currLevel.mainTask;
	
	if(mainTask == undefined) return;
	
	bonusTask1 = currLevel.bonusTask1;
	bonusTask2 = currLevel.bonusTask2;
	
	if(bonusTask1 != undefined) prevBonusTask1Completion = bonusTask1.isCompleted;
	if(bonusTask2 != undefined) prevBonusTask2Completion = bonusTask2.isCompleted;
	
	global.gameState = GameState.PROGRAMMING;
}

function GetExecutionData() {
	totalBlocksUsed = 0;
	
	with(obj_Waiter) {
		totalBlocksUsed += array_length(program);
	}
	
	show_debug_message("Total Blocks Used: " + string(totalBlocksUsed));
}

function CheckTasksCompletion() {
	var totalTasks = 1;
	var completedMT = EvaluateTask(mainTask);
	var completedBT1 = undefined;
	var completedBT2 = undefined;
	
	if(bonusTask1 != undefined) {
		completedBT1 = EvaluateTask(bonusTask1);
		totalTasks++;
	}
	
	if(bonusTask2 != undefined) {
		completedBT2 = EvaluateTask(bonusTask2);
		totalTasks++;
	}
	
	show_debug_message("Completed Main Task: " + (completedMT ? "True" : "False"));
	if(completedBT1 != undefined) show_debug_message("Completed Bonus Task 1: " + (completedBT1 ? "True" : "False"));
	if(completedBT2 != undefined) show_debug_message("Completed Bonus Task 2: " + (completedBT2 ? "True" : "False"));
}

function EvaluateTask(task) {
	switch(task.type) {
		case TaskType.GUIDETOTABLE:
			var tablesSatisfied = true;
			
			with(obj_Table) {
				var needed = task.waitersPerTable;
				var found = 0;
				var proximity = obj_GridController.GetInProximity(GridLevel.BASE, gridX, gridY);
				
				for(var i = 0; i < array_length(proximity); i++) {
					var inst = proximity[i];
					
					if(instance_exists(inst) && inst.object_index == obj_Waiter) {
						if(obj_GridController.ObjectFacingObject(inst, id)) found++;
					}
				}
				
				show_debug_message("Found: " + string(found));
				
				if(found < needed) tablesSatisfied = false;
			}
			
			return tablesSatisfied;
			
		case TaskType.COMPLETEORDERS:
			break;
		
		case TaskType.COMPLETEBONUSORDERS:
			break;
			
		case TaskType.LESSTHANBLOCKS:
			break;
	}
}