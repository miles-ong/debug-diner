function CreateMenuBlock(type, bounds, placedRects) {
    var width = sprite_get_width(spr_MenuBlock);
    var height = sprite_get_height(spr_MenuBlock);
    var xOffset = sprite_get_xoffset(spr_MenuBlock);
    var yOffset = sprite_get_yoffset(spr_MenuBlock);
    var padding = 10;
    var boundsX, boundsY;
    var attempts = 0;
    var overlaps;
    
    do {
        boundsX = random_range(bounds.left + xOffset, bounds.right - (width - xOffset));
        boundsY = random_range(bounds.top + yOffset, bounds.bottom - (height - yOffset));
        attempts++;
		
        if (attempts > 500) break;
        
        overlaps = false;
		
        for (var i = 0; i < array_length(placedRects); i++) {
            var r = placedRects[i];
			
            if (boundsX - xOffset - padding < r.x2 &&
                boundsX + (width - xOffset) + padding > r.x1 &&
                boundsY - yOffset - padding < r.y2 &&
                boundsY + (height - yOffset) + padding > r.y1) {
                overlaps = true;
                break;
            }
        }
    }
    until(!overlaps)
    
    array_push(placedRects, {
        x1: boundsX - xOffset - padding,
        y1: boundsY - yOffset - padding,
        x2: boundsX + (width - xOffset) + padding,
        y2: boundsY + (height - yOffset) + padding
    });
    
    var block = instance_create_layer(boundsX, boundsY, "MenuBlock", obj_MenuBlock);
    block.Initialize(type);
}