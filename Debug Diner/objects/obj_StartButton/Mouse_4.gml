if(global.gameState == State.RUNNING) return;

with(obj_Programmable) currentBlock = 0;
with(obj_ProgrammingPanel) SaveSelectedProgram();

global.gameState = State.RUNNING;