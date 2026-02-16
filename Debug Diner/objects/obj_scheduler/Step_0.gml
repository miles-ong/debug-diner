if(global.gameState == State.RUNNING) {
	var anyMoving = false;
	
	with(obj_Waiter) {
		if(moving) {
			anyMoving = true;
		}
	}
	
	if(!anyMoving) {
		timer -= 1;
		
		if(timer <= 0) {
			with(obj_Waiter) {
				if(currCommand < array_length(program)) {
					var command = program[currCommand];
					
					switch(command.type) {
						case Command.MOVE:
							MoveForward();
							break;
						case Command.TURN:
							Turn(command.dir);
							break;
					}
					
					currCommand += 1;
				}
			}
			
			timer = global.stepBuffer;
		}
	}
}