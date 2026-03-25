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
		DialogLine("L", "Chef", "这是左边角色的测试对话。", spr_Portrait_Left),
		DialogLine("R", "Waiter", "这是右边角色的测试对话。", spr_Portrait_Right),
		DialogLine("L", "Chef", "现在对话框会切换回左边。", spr_Portrait_Left)
	];

    Setup(testDialog, function() {
        show_debug_message("Dialog Finished!");
    });
}