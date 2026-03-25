function DialogLine(_side, _name, _text, _sprite) {
    return {
        side   : _side,    
        name   : _name,
        text   : _text,
        sprite : _sprite
    };
}

function GetRoomDialog(_room) {
    switch (_room) {

        case rm_Level1_1:
            return [
				DialogLine("L", "Chef", "这是左边角色的测试对话。", spr_Portrait_Left),
				DialogLine("R", "Waiter", "这是右边角色的测试对话。", spr_Portrait_Right),
				DialogLine("L", "Chef", "现在对话框会切换回左边。", spr_Portrait_Left)
            ];

        default:
            return [];
    }
}