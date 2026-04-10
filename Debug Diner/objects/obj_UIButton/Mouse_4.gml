if(global.gameState == GameState.TRANSITIONING) exit;

animateClick = true;
clickCurveValue = 0;

obj_UIButtonController.HandleButtonPress(buttonID, buttonLayer);