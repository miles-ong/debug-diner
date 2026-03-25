dialog = [];
idx = 0;

onFinish = noone;

margin = 32;
box_h = 220;
padding = 20;

font_name = fo_UIMedium;
font_text = fo_UISmall;

function Setup(_dialogArray, _onFinishFunc) {
    dialog = _dialogArray;
    onFinish = _onFinishFunc;
    idx = 0;

    if (array_length(dialog) <= 0) {
        Finish();
    }
}

function Next() {
    idx++;
    if (idx >= array_length(dialog)) {
        Finish();
    }
}

function Finish() {
    if (is_callable(onFinish)) onFinish();
    instance_destroy();
}

// ====== 测试模式 ======
if (room == rm_DialogTest) {
	var testDialog = [
		DialogLine("L", "Player", "Uh...", spr_Portrait_Left),
		DialogLine("R", "???", "?", spr_Portrait_Right),
		DialogLine("L", "Player", "", spr_Portrait_Left)
	];

    Setup(testDialog, function() {
        show_debug_message("Dialogue Finished!");
    });
}