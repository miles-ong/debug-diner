if(global.gameState != GameState.EXECUTING) exit;

if(colliding && animateCollision) {
	if(collisionPhase == 0) {
		moveProgress += global.stepSpeed;
		
		if(moving) {
			var distance = moveProgress / BOARD_TILE_SIZE;
			x = lerp(startX, endX, distance);
			y = lerp(startY, endY, distance);
		}
		
		if(moveProgress >= BOARD_TILE_SIZE * 0.25) {
			collisionPhase = 1;
			collisionProgress = 0;
			collisionStartX = x;
			collisionStartY = y;
		}
	}
	else {
		if(collisionProgress == 0) {
			obj_LevelController.OnCollision();
			obj_ScreenFilter.AddFilter(new Flash(1 / global.collisionDuration, c_red, 0.5));
		}
		
		collisionProgress++;
		var t = collisionProgress / global.collisionDuration;
		var curveT = animcurve_channel_evaluate(collisionCurveSpeed, t);
		x = lerp(collisionStartX, startX + knockbackX, t);
		y = lerp(collisionStartY, startY + knockbackY, t);
		image_blend = merge_color(c_white, c_red, curveT);
		image_angle = lerp(0, collisionRotation, curveT);
		
		if(collisionProgress >= global.collisionDuration) {
			colliding = false;
			collisionPhase = 0;
			collisionProgress = 0;
			moving = false;
			moveProgress = 0;
			knockbackX = 0;
			knockbackY = 0;
			obj_LevelController.FinalizeLevel();
		}
	}
}
else if(moving) {
	moveProgress += global.stepSpeed;
	var distance = moveProgress / BOARD_TILE_SIZE;
	x = lerp(startX, endX, distance);
	y = lerp(startY, endY, distance);
	
	if(moveProgress >= BOARD_TILE_SIZE) {
		var oldX = gridX;
		var oldY = gridY;
		gridX = targetGridX;
		gridY = targetGridY;
		x = endX;
		y = endY;
		moving = false;
		moveProgress = 0;
		// handle grid swapping here
	}
}