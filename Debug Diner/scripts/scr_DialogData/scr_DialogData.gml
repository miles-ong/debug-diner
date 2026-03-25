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
                DialogLine("Chef",   "。。。。。。。。。。。"),
                DialogLine("Waiter", "。。。。。。。。。。。"),
            ];

        case rm_Level1_2:
            return [
                DialogLine("Chef", "。。。。。。。。"),
            ];

        default:
            return [];
    }
}