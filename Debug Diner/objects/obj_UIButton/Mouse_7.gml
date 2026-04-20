/// MOUSE LEFT RELEASED

if (global.gameState == GameState.TRANSITIONING) exit;

// trigger click animation
animateClick = true;
clickCurveValue = 0;

// notify controller
obj_UIButtonController.HandleButtonPress(buttonID, buttonLayer);