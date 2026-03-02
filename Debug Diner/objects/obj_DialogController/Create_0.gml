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
        DialogLine("Chef", "这是对话测试房间。"),
        DialogLine("Waiter", "现在我们正在测试对话框系统。"),
        DialogLine("Chef", "如果能正常翻页，说明系统正常运行。")
    ];

    Setup(testDialog, function() {
        show_debug_message("Dialog Finished!");
    });
}