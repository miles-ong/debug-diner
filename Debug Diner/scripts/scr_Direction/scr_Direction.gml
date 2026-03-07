enum Direction {
	NORTH = 0,
	EAST = 1,
	SOUTH = 2,
	WEST = 3,
	HEIGHT = 4
}

enum TurnDirection {
	LEFT = 0,
	RIGHT = 1
}

function GetGridCoordinatesInDirection(_gx, _gy, _direction, _distance = 1) {
	switch(_direction) {
		case Direction.NORTH: _gy -= _distance; break;
		case Direction.EAST: _gx += _distance; break;
		case Direction.SOUTH: _gy += _distance; break;
		case Direction.WEST: _gx -= _distance; break;
	}
	
	return {
		gx : _gx,
		gy : _gy
	};
}

/// @description Gets the direction an entity is moving using world or grid coordinates
/// @param _sx startX of an entity
/// @param _sy startY of an entity
/// @param _tx targetX of an entity
/// @param _ty targetY of an entity
function GetMoveDirection(_sx, _sy, _tx, _ty) {
	if(_sx > _tx) return Direction.WEST;
	if(_sx < _tx) return Direction.EAST;
	if(_sy > _ty) return Direction.NORTH;
	if(_sy < _ty) return Direction.SOUTH;
}

/// @description Gets the opposite direction of a given direction
/// @param _direction Direction to be inversed
function GetOppositeDirection(_direction) {
	switch(_direction) {
		case Direction.NORTH: return Direction.SOUTH;
		case Direction.EAST: return Direction.WEST;
		case Direction.SOUTH: return Direction.NORTH;
		case Direction.WEST: return Direction.EAST;
	}
}

function DirectionToString(_direction) {
	switch(_direction) {
		case Direction.NORTH: return "North";
		case Direction.EAST: return "East";
		case Direction.SOUTH: return "South";
		case Direction.WEST: return "West";
	}
}

function TurnDirectionToString(_turnDirection) {
	switch(_turnDirection) {
		case TurnDirection.LEFT: return "Left";
		case TurnDirection.RIGHT: return "Right";
	}
}