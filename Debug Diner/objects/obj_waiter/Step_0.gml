if(moving) {
	moveProgress += global.stepSpeed;
	var distance = moveProgress / TILE_SIZE;
	x = lerp(startX, endX, distance);
	y = lerp(startY, endY, distance);
	
	if(moveProgress >= TILE_SIZE) {
		gridX = targetGridX;
		gridY = targetGridY;
		x = endX;
		y = endY;
		moving = false;
	}
}

