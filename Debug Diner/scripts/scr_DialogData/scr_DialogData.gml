/// 返回当前房间的对话数组（每一项是一个 struct）
/// 没有对话就返回

function DialogLine(_name, _text) {
    return {
        name : _name,
        text : _text
    };
}

function GetRoomDialog(_room) {
    switch (_room) {

        case rm_Level1_1:
            return [
                DialogLine("Chef",   "欢迎来到 Debug Diner！这一关先熟悉基本操作。"),
                DialogLine("Waiter", "明白！我会按程序把客人带到桌边。"),
            ];

        case rm_Level1_2:
            return [
                DialogLine("Chef", "注意流程顺序，不然会卡住。"),
            ];

        default:
            return [];
    }
}