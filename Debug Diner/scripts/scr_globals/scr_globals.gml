global.stepSpeed = FAST_SPEED; // pixels traveled per frame
global.stepBuffer = 12; // frames in between steps
global.collisionDuration = 40;

global.gameState = GameState.PROGRAMMING;

global.draggingBlock = noone;
global.selectedProgram = noone;
global.editingBlockContent = noone;
global.hoveredBlock = noone;
global.hoveredBlockContent = noone;
global.hoveredBlockSlot = noone;
global.hoveredProgrammable = noone;

global.currentRegion = LevelRegion.NORTHAMERICA;
global.currentLevel = undefined;

global.soundEffectsVolume = 1;

global.uiTransitionAlpha = 1;