if(room != rm_Cutscene) {
	idx = 0;
	exit;
}

switch(idx) {
	case 0: draw_self(); break;
	case 1: draw_sprite(spr_Cutscene1_1, 0, 0, 0); break;
	case 2: draw_sprite(spr_Cutscene1_2, 0, 0, 0); break;
	case 3: draw_sprite(spr_Cutscene1_3, 0, 0, 0); break;
	case 4: draw_sprite(spr_Cutscene1_4, 0, 0, 0); break;
	case 5: draw_sprite(spr_Cutscene1_5, 0, 0, 0); break;
}