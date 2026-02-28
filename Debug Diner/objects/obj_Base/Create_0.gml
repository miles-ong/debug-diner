var gridPos = obj_GridController.WorldToGrid(x, y);
gridX = gridPos.gridX;
gridY = gridPos.gridY;

canCollide = true;

layer = layer_get_id("Base");