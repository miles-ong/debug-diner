global.stepSpeed = FAST_SPEED; // pixels traveled per frame
global.stepBuffer = 12; // frames in between steps

global.gameState = GameState.PROGRAMMING;
global.selectedProgram = noone;

global.isDraggingBlock = false;
global.isEditingArgument = false;
global.editingArgument = noone;
global.hoveredBlock = noone;
global.hoveredArgument = noone;
global.hoveredSlot = noone;