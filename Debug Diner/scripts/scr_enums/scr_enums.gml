enum ProgrammableSprite {
	UNSELECTED = 0,
	SELECTED = 1
}

enum GridLevel {
	FLOOR,
	BASE
}

enum ButtonLayer {
	LEVELSELECT,
	LEVELRESULT,
}

function GridLevelToString(_gridLevel) {
	switch(_gridLevel) {
		case GridLevel.FLOOR: return "Floor";
		case GridLevel.BASE: return "Base";
	}
}