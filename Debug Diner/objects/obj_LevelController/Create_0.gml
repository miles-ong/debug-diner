if(instance_exists(obj_LevelController) > 1) {
	instance_destroy();
	return;
}

totalBlocksUsed = 0;

mainTask = noone;
bonusTask1 = noone;
bonusTask2 = noone;

prevBonusTask1Completion = false;
prevBonusTask2Completion = false;

function StartLevel() {
	totalBlocksUsed = 0;
	
	var currLevel = global.currentLevel;
	
	if(currLevel == noone) return;
	
	mainTask = currLevel.mainTask;
	
	if(mainTask == noone) return;
	
	bonusTask1 = currLevel.bonusTask1;
	bonusTask2 = currLevel.bonusTask2;
	
	if(bonusTask1 != noone) prevBonusTask1Completion = bonusTask1.isCompleted;
	if(bonusTask2 != noone) prevBonusTask2Completion = bonusTask2.isCompleted;
	
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
	
	if(bonusTask1 != noone) {
		completedBT1 = EvaluateTask(bonusTask1);
		totalTasks++;
	}
	
	if(bonusTask2 != noone) {
		completedBT2 = EvaluateTask(bonusTask2);
		totalTasks++;
	}
	
	show_debug_message("Completed Main Task: " + string(completedMT));
	if(completedBT1 != undefined) show_debug_message("Completed Bonus Task 1: " + string(completedBT1));
	if(completedBT2 != undefined) show_debug_message("Completed Bonus Task 2: " + string(completedBT2));
}

function EvaluateTask(task) {
	switch(task) {
		case TaskType.GUIDETOTABLE:
			var tablesCovered = true;
			
			with(obj_Table) {
				var proximity = obj_GridController.GetInProximity(GridLevel.BASE, gridX, gridY);
				
				for(var i = 0; i < array_length(proximity); i++) {
					var inst = proximity[i];
					
					if(instance_exists(inst) && inst == obj_Waiter) {
						// fix this stuff
					}
				}
			}
			
			return true;
			
		case TaskType.COMPLETEORDERS:
			break;
		
		case TaskType.COMPLETEBONUSORDERS:
			break;
			
		case TaskType.LESSTHANBLOCKS:
			break;
	}
}

//type = TaskType.LESSTHANBLOCKS;
//threshold = 0;
//description = "";
//isCompleted = false;

//name = "";
//trophy = noone;
//unlocked = false;
//completeTask = noone;
//bonusTask1 = noone;
//bonusTask2 = noone;
//targetRoom = noone;