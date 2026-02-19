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
	LEFT = 0,
	RIGHT = 1
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

enum ArgumentType {
	INT,
	BOOL,
	TEXT,
	DROPDOWN
}

enum GridLevel {
	FLOOR,
	BASE,
	UPPER
}

enum CellType {
	FLOOR,
	HAZARD
}