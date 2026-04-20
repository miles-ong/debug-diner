event_inherited();

draw_self();
draw_set_alpha(image_alpha);

var currLevel = global.currentLevel;

if(currLevel == undefined) return;

var left = x - sprite_width / 2;
var top  = y - sprite_height / 2;
var offsetX = left + UI_CONTAINER_PADDING;
var offsetY = top + UI_CONTAINER_PADDING;
var iconWidth = sprite_get_width(spr_CheckBoxEmpty);
var iconHeight = sprite_get_height(spr_CheckBoxEmpty);
var textOffsetX = offsetX + iconWidth + UI_ICON_PADDING;
var wrapWidth = sprite_width - (UI_CONTAINER_PADDING * 2) - iconWidth - UI_ICON_PADDING;

draw_set_color(c_white);
draw_set_font(fo_UISmall);

draw_sprite(currLevel.mainTask.isCompleted ? spr_CheckBoxFilled : spr_CheckBoxEmpty, 0, offsetX, offsetY);
draw_text_ext(textOffsetX, offsetY - 2, currLevel.mainTask.description, -1, wrapWidth);
var textHeight = string_height_ext(currLevel.mainTask.description, -1, wrapWidth);
offsetY += max(iconHeight, textHeight) + 8;

draw_set_color(c_yellow);

if(currLevel.bonusTask1 != undefined) {
	draw_sprite(currLevel.bonusTask1.isCompleted ? spr_CheckBoxFilled : spr_CheckBoxEmpty, 0, offsetX, offsetY);
	draw_text_ext(textOffsetX, offsetY - 2, currLevel.bonusTask1.description, -1, wrapWidth);
	textHeight = string_height_ext(currLevel.bonusTask1.description, -1, wrapWidth);
	offsetY += max(iconHeight, textHeight) + 8;
}

if(currLevel.bonusTask2 != undefined) {
	draw_sprite(currLevel.bonusTask2.isCompleted ? spr_CheckBoxFilled : spr_CheckBoxEmpty, 0, offsetX, offsetY);
	draw_text_ext(textOffsetX, offsetY - 2, currLevel.bonusTask2.description, -1, wrapWidth);
}

draw_set_alpha(1);

if(highlight) shader_reset();