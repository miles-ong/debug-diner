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

function FinalizeLevel() {
	global.gameState = GameState.MENUS;
	CheckTasksCompletion();
	layer_set_visible("LevelResult", true);
}

function LoadExecutionData() {
	totalBlocksUsed = 0;
	
	with(obj_Waiter) {
		other.totalBlocksUsed += CountBlocks(program);
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
	
	if(completedMT) {
		mainTask.isCompleted = true;
		
		if(completedBT1 != undefined) {
			bonusTask1.isCompleted = completedBT1;
		}
		
		if(completedBT2 != undefined) {
			bonusTask2.isCompleted = completedBT2;
		}
	}
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
				
				if(found < needed) tablesSatisfied = false;
			}
			
			return tablesSatisfied;
			
		case TaskType.COMPLETEORDERS:
			break;
		
		case TaskType.COMPLETEBONUSORDERS:
			break;
			
		case TaskType.LESSTHANBLOCKS:
			return totalBlocksUsed < task.blocks;
	}
}