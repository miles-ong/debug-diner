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

enum MenuBlockType {
	LEVELSELECT,
	CONTINUE,
	SETTINGS
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

function SetBlockColor(c) {
	switch(c) {
		case BlockColor.WHITE: color = c_white; break;
		case BlockColor.RED: color = make_color_rgb(235, 100, 100); break;
		case BlockColor.ORANGE: color = make_color_rgb(240, 165, 80); break;
		case BlockColor.YELLOW: color = make_color_rgb(240, 225, 80); break;
		case BlockColor.GREEN: color = make_color_rgb(90, 200, 110); break;
		case BlockColor.TEAL: color = make_color_rgb(60, 195, 185); break;
		case BlockColor.BLUE: color = make_color_rgb(90, 155, 240); break;
		case BlockColor.PURPLE: color = make_color_rgb(170, 100, 230); break;
		case BlockColor.PINK: color = make_color_rgb(235, 120, 180); break;
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