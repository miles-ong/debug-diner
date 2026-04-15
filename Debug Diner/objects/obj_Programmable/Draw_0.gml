event_inherited();

image_index = global.selectedProgram == id ? ProgrammableSprite.SELECTED : ProgrammableSprite.UNSELECTED;

var targetScale = global.hoveredProgrammable == id ? hoverScale : 1;
image_xscale = lerp(image_xscale, targetScale, scaleSpeed);
image_yscale = lerp(image_yscale, targetScale, scaleSpeed);

draw_self();

if(highlight) {
	DrawHighlightArrow();
	shader_reset();
}