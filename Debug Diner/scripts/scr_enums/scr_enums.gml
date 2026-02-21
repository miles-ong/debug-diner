enum GameState {
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

enum BlockSprite {
	DISCONNECTED = 0,
	CONNECTED = 1,
}

enum SlotSprite {
	CANNOTCONNECT = 0,
	CANCONNECT = 1
}

enum MenuBlockType {
	NEXTLEVEL,
	SETTINGS
}

enum SlotType {
	SEQUENCE,
	BODY
}

enum ArgumentType {
	INT,
	BOOL,
	TEXT,
	DROPDOWN
}

enum TaskType {
	LESSTHANBLOCKS
}

enum GridLevel {
	FLOOR,
	BASE
}

enum CellType {
	FLOOR,
	SOLID
}