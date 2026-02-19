if(global.gameState == GameState.RUNNING) {
	var anyMoving = false;
	
	with(obj_Programmable) {
		if(isMoving) anyMoving = true;
	}
	
	if(!anyMoving) {
		timer -= 1;
		
		if(timer <= 0) {
			var programComplete = true;
			
			with(obj_Programmable) {
				if(currentBlock < array_length(program)) {
					programComplete = false;
					var node = program[currentBlock];
					
					switch(node.type) {
						case BlockType.MOVE:
							MoveForward();
							break;
							
						case BlockType.TURN:
							Turn(node.args.turnDirection);
							break;
					}
					
					currentBlock += 1;
				}
			}
			
			if(programComplete) global.gameState = GameState.PROGRAMMING;
			
			timer = global.stepBuffer;
		}
	}
}