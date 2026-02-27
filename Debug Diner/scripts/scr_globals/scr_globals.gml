global.stepSpeed = FAST_SPEED; // pixels traveled per frame
global.stepBuffer = 12; // frames in between steps

global.gameState = GameState.PROGRAMMING;
global.selectedProgram = noone;

global.isDraggingBlock = false;
global.isEditingArgument = false;
global.editingBlockContent = noone;
global.editingProgrammable = noone;
global.hoveredBlock = noone;
global.hoveredBlockContent = noone;
global.hoveredBlockSlot = noone;
global.hoveredProgrammable = noone;

global.currentLevel = noone;