if(global.gameState == GameState.RUNNING) {
	var anyMoving = false;
	
	with(obj_Programmable) {
		if(isMoving) anyMoving = true;
	}
	
	if(!anyMoving) {
		timer -= 1;
		
		if(timer <= 0) {
			timer = global.stepBuffer;
			var programComplete = true;
			
			with(obj_Programmable) {
				if(array_length(programStack) > 0) {
					programComplete = false;
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
					
					if(array_length(programStack) > 0) {
						top = programStack[array_length(programStack) - 1];
						
						if(top.index < array_length(top.nodes)) {
							var node = top.nodes[top.index];
							top.index += 1;
							
							switch(node.type) {
								case BlockType.MOVE:
									MoveForward();
									break;
									
								case BlockType.TURN:
									Turn(node.args.turnDirection);
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
			
			if(programComplete) {
				obj_LevelController.FinalizeLevel();
			}
		}
	}
}