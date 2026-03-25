// --- Setup ---
debugLabel = "[obj_StepController]";
floorPlannedSteps = {};
basePlannedSteps = {};
timer = 0;

/// @description Resets setup variables
function Initialize() {
	floorPlannedSteps = {};
	basePlannedSteps = {};
	timer = 0;
	show_debug_message($"{debugLabel} Initialized");
}

#region Planning
/// @description Adds an entity to be evaluated during the next execution phase
/// @param _entity The entity to be evaluated
function LoadStep(_entity) {
	var steps = _entity.gridLevel == GridLevel.FLOOR ? floorPlannedSteps : basePlannedSteps;
	var tx = _entity.targetGridX;
	var ty = _entity.targetGridY;
	var key = Key(tx, ty);
	
	if(!variable_struct_exists(steps, key)) steps[$ key] = [];
	
	array_push(steps[$ key], _entity);
	show_debug_message($"{debugLabel} Loaded step for {_entity.label}");
}

/// @description Evaluates all entities' plans before execution. Handles collision if plans overlap
function ResolveSteps() {
	CheckCollisions(floorPlannedSteps);
	CheckCollisions(basePlannedSteps);
	floorPlannedSteps = {};
	basePlannedSteps = {};
	ChangeGameState(GameState.EXECUTING);
}

/// @description Checks for potential collisions from the outcomes of entities' planned steps
/// @param _steps The step map to check
function CheckCollisions(_steps) {
	var keys = variable_struct_get_names(_steps);
	var level = _steps == floorPlannedSteps ? GridLevel.FLOOR : GridLevel.BASE;
	show_debug_message($"{debugLabel} Checking collisions for {string(level)} entities");
	
	for(var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		var gCoords = ParseKey(key);
		var tx = gCoords.gx;
		var ty = gCoords.gy;
		var entities = _steps[$ key];
		var entitiesLen = array_length(entities);
		var e;
		
		if(entitiesLen > 1) {
			show_debug_message($"{debugLabel} {string(entitiesLen)} {GridLevelToString(level)} entities plan to end on ({tx}, {ty})");
			var collisions = [];
			
			for(var j = 0; j < entitiesLen; j++) {
				e = entities[j];
				
				if(e.collision) array_push(collisions, e);
			}
			
			var collisionsLen = array_length(collisions);
			
			if(collisionsLen > 1) {
				for(var c = 0; c < collisionsLen; c++) {
					var co = collisions[c];
					co.HandleCollision(GetMoveDirection(co.gridX, co.gridY, co.targetGridX, co.targetGridY));
				}
				
				show_debug_message($"{debugLabel} {string(collisionsLen)} {GridLevelToString(level)} entities colliding on ({tx}, {ty})");
				continue;
			}
			
			show_debug_message($"{debugLabel} No collisions occurred between {string(entitiesLen)} {GridLevelToString(level)} entities on ({tx}, {ty})");
		}
		
		e = entities[0];
		var occupant = obj_GridController.Get(e.targetGridX, e.targetGridY, e.gridLevel);
		
		if(occupant != noone) {
			var dir = GetMoveDirection(e.gridX, e.gridY, e.targetGridX, e.targetGridY);
			e.HandleCollision(dir);
			occupant.HandleCollision(GetOppositeDirection(dir));
			show_debug_message($"{debugLabel} Handling head on collision");
			continue;
		}
	}
}
#endregion

#region Reading
/// @description Reads programmables and plans operations for each programmed entity
function ReadPrograms() {
	var programComplete = true;
	show_debug_message($"{debugLabel} Reading programs");
	
	with(obj_Programmable) {
		if(array_length(programStack) > 0) {
			show_debug_message($"{debugLabel} Reading '{label}''s program");
			programComplete = false;
			var consumeStep = false;
			
			while(!consumeStep) {
				var top = programStack[array_length(programStack) - 1];
				
				while(top.index >= array_length(top.nodes)) {
					if(variable_struct_exists(top, "isLoop") && top.remaining > 0) {
						top.index = 0;
						top.remaining -= 1;
						break;
					}
					else {
						array_pop(programStack);
						
						if(array_length(programStack) == 0) break;
						
						top = programStack[array_length(programStack) - 1];
					}
				}
				
				if(array_length(programStack) == 0) {
					consumeStep = true;
					break;
				}
				
				top = programStack[array_length(programStack) - 1];
				
				if(top.index < array_length(top.nodes)) {
					var node = top.nodes[top.index];
					top.index += 1;
					
					switch(node.type) {
						case BlockType.MOVE:
							PlanMove();
							consumeStep = true;
							break;
							
						case BlockType.TURN:
							Turn(node.args.turnDirection);
							consumeStep = true;
							break;
							
						case BlockType.LOOP:
							if(node.args.count > 0) {
								var frame = MakeFrame(node.body, 0);
								frame.isLoop = true;
								frame.remaining = node.args.count - 1;
								array_push(programStack, frame);
							}
							break;
					}
				}
			}
		}
	}
	
	return programComplete;
}
#endregion

#region Helpers
/// @description Helper to parse grid coordinates into keys for grid maps
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
function Key(_gx, _gy) {
	return $"{_gx}_{_gy}";
}

/// @description Parses a string key back into it's original grid coordinates
/// @param _key String with the format: "gx_gy"
function ParseKey(_key) {
	var parts = string_split(_key, "_");
	
	return {
		gx : real(parts[0]),
		gy : real(parts[1])
	};
}
#endregion