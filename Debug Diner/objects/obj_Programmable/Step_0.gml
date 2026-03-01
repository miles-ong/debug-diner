if(isCrashing) {
	if(crashPhase == 0) {
		moveProgress += global.stepSpeed;
		var distance = moveProgress / BOARD_TILE_SIZE;
		x = lerp(startX, endX, distance);
		y = lerp(startY, endY, distance);
		
		if(moveProgress >= BOARD_TILE_SIZE * 0.25) {
			crashPhase = 1;
			crashProgress = 0;
		}
	}
	else {
		obj_LevelController.OnCrash();
		crashProgress++;
		var t = crashProgress / crashDuration;
		var curveT = animcurve_channel_evaluate(animcurve_get_channel(cu_CrashFallback, "spd"), t);
		var crashStartX = lerp(startX, endX, 0.25);
		var crashStartY = lerp(startY, endY, 0.25);
		
		x = lerp(crashStartX, startX, t);
		y = lerp(crashStartY, startY, t);
		
		image_blend = merge_color(c_white, c_red, curveT);
		image_angle = lerp(0, crashRotation, curveT);
		
		if(crashProgress >= crashDuration) {
			isCrashing = false;
			isMoving = false;
			crashPhase = 0;
			moveProgress = 0;	
		}
	}
}

if(isMoving && !isCrashing) {
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
		isMoving = false;
		moveProgress = 0;
		
		obj_GridController.Remove(GridLevel.BASE, oldX, oldY);
		obj_GridController.Set(GridLevel.BASE, gridX, gridY, id);
	}
}