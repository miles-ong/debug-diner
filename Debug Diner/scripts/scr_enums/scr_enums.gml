enum State {
	PROGRAMMING,
	RUNNING
}

enum Direction {
	NORTH = 0,
	EAST = 1,
	SOUTH = 2,
	WEST = 3
}

enum TurnDirection {
	LEFT,
	RIGHT
}

enum BlockType {
	PROGRAM,
	MOVE,
	TURN,
	IF
}

enum SlotType {
	SEQUENCE,
	BODY,
	END
}