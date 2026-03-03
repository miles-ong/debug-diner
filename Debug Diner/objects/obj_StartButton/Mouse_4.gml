if(global.gameState != GameState.PROGRAMMING) return;

if(global.editingBlockContent != noone) global.editingBlockContent.owner.OnArgumentChanged();
with(obj_ProgrammingPanel) SaveSelectedProgram();
with(obj_Programmable) programStack = [MakeFrame(program, 0)];

obj_LevelController.LoadExecutionData();
global.gameState = GameState.EXECUTING;