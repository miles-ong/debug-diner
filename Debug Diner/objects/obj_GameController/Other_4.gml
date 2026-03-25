ClearLayers();

global.isDraggingBlock = false;
global.selectedProgram = noone;
global.editingBlockContent = noone;
global.hoveredBlock = noone;
global.hoveredBlockContent = noone;
global.hoveredBlockSlot = noone;
global.hoveredProgrammable = noone;

if(room == rm_StartRoom) {
	ChangeGameState(GameState.MENUS);
	return;
}

if(room == rm_MainMenu) {
    var bounds = obj_Bounds.GetBounds();
    
    var mainBlock = instance_create_layer(bounds.left + 50, bounds.top + 50, "MenuBlock", obj_MainMenuBlock);
    
    var mainWidth = sprite_get_width(mainBlock.sprite_index);
    var mainHeight = sprite_get_height(mainBlock.sprite_index);
    var mainXOffset = sprite_get_xoffset(mainBlock.sprite_index);
    var mainYOffset = sprite_get_yoffset(mainBlock.sprite_index);
    
    var placedRects = [{
        x1: mainBlock.x - mainXOffset,
        y1: mainBlock.y - mainYOffset,
        x2: mainBlock.x + (mainWidth - mainXOffset),
        y2: mainBlock.y + (mainWidth - mainYOffset)
    }];
    
    CreateMenuBlock(MenuBlockType.LEVELSELECT, bounds, placedRects);
    CreateMenuBlock(MenuBlockType.CONTINUE, bounds, placedRects);
    CreateMenuBlock(MenuBlockType.SETTINGS, bounds, placedRects);
    
    return;
}