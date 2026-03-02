global.gameState = GameState.MENUS;

if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
    Next();
}