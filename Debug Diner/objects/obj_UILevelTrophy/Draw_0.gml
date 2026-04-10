event_inherited();

draw_self();

var trophy = global.currentLevel.trophy;

if(trophy == noone) trophy = spr_TrophyBurger;

var tasks = [
	global.currentLevel.mainTask,
	global.currentLevel.bonusTask1,
	global.currentLevel.bonusTask2
];

var total = 0;
var completed = 0;

for(var i = 0; i < array_length(tasks); i++) {
	if(tasks[i] != undefined) {
		total++;
		
		if(tasks[i].isCompleted) completed++;
	}
}

var index = 0;

if(total > 0) index = ceil((completed / total) * 3);

draw_sprite(trophy, index, x, y);