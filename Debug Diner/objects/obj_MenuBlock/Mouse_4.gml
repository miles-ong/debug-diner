if(global.draggingBlock != noone || global.gameState == GameState.TRANSITIONING) return;

global.draggingBlock = id;

if(isConnected) obj_MainMenuBlock.Disconnect();

layer = layer_get_id("MenuBlockDragging");
isDragging = true;