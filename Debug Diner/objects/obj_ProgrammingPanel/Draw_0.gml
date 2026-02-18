draw_self();

draw_set_color(make_color_rgb(200, 200, 200));
draw_set_alpha(0.35);

var panelW = sprite_width;
var panelH = sprite_height;

var cols = ceil(panelW / cellSize);
var rows = ceil(panelH / cellSize);

for(var i = 0; i <= cols; i++) {
	var lineX = x + i * cellSize;
	draw_line(lineX, y, lineX, y + panelH);
}

for(var j = 0; j <= rows; j++) {
	var lineY = y + j * cellSize;
	draw_line(x, lineY, x + panelW, lineY);
}

draw_set_alpha(1);
