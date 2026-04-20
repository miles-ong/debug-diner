if(instance_exists(obj_LevelController) > 1) {
	instance_destroy();
	return;
}

debugLabel = "[LevelController]";

collided = false;
customersSatisfied = false;
bonusOrdersSatisfied = false;
totalBlocksUsed = 0;
ordersCompleted = 0;
blockTypesUsed = ds_map_create();

mainTask = undefined;
bonusTask1 = undefined;
bonusTask2 = undefined;

prevBonusTask1Completion = false;
prevBonusTask2Completion = false;

function InitializeLevel() {
	collided = false;
	totalBlocksUsed = 0;
	ds_map_clear(blockTypesUsed);
	var currLevel = global.currentLevel;
	
	if(currLevel == noone) return;
	
	mainTask = currLevel.mainTask;
	
	if(mainTask == noone) return;
	
	bonusTask1 = currLevel.bonusTask1;
	bonusTask2 = currLevel.bonusTask2;
	
	if(bonusTask1 != undefined) prevBonusTask1Completion = bonusTask1.isCompleted;
	if(bonusTask2 != undefined) prevBonusTask2Completion = bonusTask2.isCompleted;
	
	obj_GridController.Initialize();
	obj_StepController.Initialize();
	
	var enabledBlocks;
	
	if(currLevel.enabledBlocks == undefined) {
		enabledBlocks = [
			BlockType.MOVE,
			BlockType.TURN,
			BlockType.LOOP,
			BlockType.WAIT,
			BlockType.IF,
			BlockType.WHILE,
			BlockType.COND_AHEAD_IS
		];
	}
	else {
		enabledBlocks = currLevel.enabledBlocks;
	}
	
	obj_BlockBank.Initialize(enabledBlocks);
	
	if(currLevel.customers != undefined) {
		if(is_array(currLevel.customers)) {
			for(var i = 0; i < array_length(currLevel.customers); i++) {
				with(obj_Chair) {
					if(uniqueId == currLevel.customers[i].chairId) {
						if(customer != undefined) {
							show_debug_message($"{debugLabel} Multiple customers cannot share the same chair");
							continue;
						}
						else {
							customer = currLevel.customers[i];
							continue;
						}
					}
				}
				
				show_debug_message($"{debugLabel} No chair ID exists that matches the customer's chair ID");
			}
		}
		else {
			with(obj_Chair) {
				if(uniqueId == currLevel.customers.chairId) customer = currLevel.customers;
			}
		}
	}
}

function StartLevel() {
	if(!global.currentLevel.eventCompleted) obj_EventController.Initialize(global.currentLevel.eventSequence);
	
	ChangeGameState(GameState.PROGRAMMING);
	obj_EventController.FireSignal(EventSignal.LEVELSTARTED);
}

function OnCollision() {
	if(collided) return;
	
	collided = true;
	audio_play_sound(sfx_RobotCrash, 1, 0);
}

function FinalizeLevel() {
	ChangeGameState(GameState.MENUS);
	show_debug_message($"{debugLabel} Total Blocks Used: {totalBlocksUsed}");
	var result = CheckTasksCompletion();
	layer_set_visible("LevelResult", true);
	obj_UILevelResult.success = result;
	obj_UIButtonController.success = result;
	
	with(obj_UIButton) {
		if(buttonID == 1) text = result ? "Continue" : "Retry";
	}
}

function LoadExecutionData() {
	totalBlocksUsed = 0;
	
	with(obj_Waiter) {
		other.totalBlocksUsed += CountBlocks(program);
		CollectBlockTypes(program, other.blockTypesUsed);
	}
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
		
		var nextLevelIdx = obj_GameController.GetNextLevelIndex();
		var contRegion = global.currentRegion;
		var contLevel;
		
		if(nextLevelIdx == 0) {
			var nextRegion = obj_GameController.GetNextRegion(global.currentRegion);
			
			if(nextRegion != undefined) {
				var regionLevels = obj_GameController.GetRegionLevels(nextRegion);
				contRegion = nextRegion;
				contLevel = regionLevels[nextLevelIdx];
			}
		}
		else {
			contLevel = obj_GameController.GetLevel(nextLevelIdx);
		}
		
		if(contLevel != undefined && !contLevel.unlocked) {
			contLevel.unlocked = true;
			obj_GameController.continueRegion = contRegion;
			obj_GameController.continueLevelIdx = nextLevelIdx;
			show_debug_message($"{debugLabel} Unlocked '{contLevel.name}'");
		}
		
		return true;
	}
	
	return false;
}

function EvaluateTask(task) {
	if(collided) return false;
	
	switch(task.type) {
		case TaskType.GUIDETOTABLE:
			var tablesSatisfied = true;
			
			with(obj_Table) {
				var needed = task.waitersPerTable;
				var found = 0;
				var proximity = obj_GridController.GetInProximity(gridX, gridY, GridLevel.BASE);
				
				for(var i = 0; i < array_length(proximity); i++) {
					var inst = proximity[i];
					
					if(instance_exists(inst) && (inst.object_index == obj_Waiter || object_is_ancestor(inst.object_index, obj_Waiter))) {
						if(obj_GridController.IsEntityFacingEntity(inst, id)) found++;
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
			
		case TaskType.USEBLOCK:
			return ds_map_exists(blockTypesUsed, task.block); 
			
		case TaskType.NOTUSEBLOCK:
			return !ds_map_exists(blockTypesUsed, task.block);
	}		
}
