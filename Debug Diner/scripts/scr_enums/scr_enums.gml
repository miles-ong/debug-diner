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
	LOOP,
	IF
}

enum BlockColor {
	WHITE,
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	TEAL,
	BLUE,
	PURPLE,
	PINK
}

enum MenuBlockType {
	LEVELSELECT,
	CONTINUE,
	SETTINGS
}

enum SlotType {
	SEQUENCE,
	BODY
}

enum BlockContentType {
	ARGUMENT,
	BUTTON,
	DISPLAY
}

enum BlockArgumentType {
	INT,
	BOOL,
	TEXT,
	CYCLE,
	NONE
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