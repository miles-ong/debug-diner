gridX = round(x / TILE_SIZE);
gridY = round(y / TILE_SIZE);
x = gridX * TILE_SIZE;
y = gridY * TILE_SIZE;

targetGridX = gridX;
targetGridY = gridY;
startX = x;
startY = y;
endX = x;
endY = y;

moving = false;
moveProgress = 0;

program = [
	{ type: Command.MOVE },
	{ type: Command.TURN, dir: 1 },
	{ type: Command.MOVE },
	{ type: Command.TURN, dir: -1 },
	{ type: Command.MOVE }
];

currCommand = 0;