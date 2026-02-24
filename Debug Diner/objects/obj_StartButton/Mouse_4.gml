if(global.gameState == GameState.RUNNING) return;

with(obj_ProgrammingPanel) SaveSelectedProgram();
with(obj_Programmable) programStack = [MakeFrame(program, 0)];

global.gameState = GameState.RUNNING;