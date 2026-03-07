enum ProgrammableSprite {
	UNSELECTED = 0,
	SELECTED = 1
}

enum TrophySprite {
	EMPTY = 0,
	BRONZE = 1,
	SILVER = 2,
	GOLD = 3
}

enum BlockType {
	PROGRAM,
	MOVE,
	TURN,
	LOOP,
	IF
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

enum SlotType {
	SEQUENCE,
	BODY
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

enum TaskType {
	GUIDETOTABLE,
	COMPLETEORDERS,
	COMPLETEBONUSORDERS,
	LESSTHANBLOCKS,
	USEBLOCK,
	NOTUSEBLOCK
}

enum GridLevel {
	FLOOR,
	BASE
}

enum LevelRegion {
	NORTHAMERICA,
	SOUTHAMERICA,
	EUROPE,
	ASIA,
	AFRICA,
	AUSTRALIA
}

enum ButtonLayer {
	LEVELSELECT,
	LEVELRESULT,
}

enum CustomerTrait {
	MESSY,
	VIP,
	FORMAL,
	NONE
}

function GridLevelToString(_gridLevel) {
	switch(_gridLevel) {
		case GridLevel.FLOOR: return "Floor";
		case GridLevel.BASE: return "Base";
	}
}

function BlockTypeToString(type) {
	switch(type) {
		case BlockType.PROGRAM: return "Program";
		case BlockType.MOVE: return "Move Forward";
		case BlockType.TURN: return "Turn";
		case BlockType.LOOP: return "Loop";
		case BlockType.IF: return "If";
	}
}