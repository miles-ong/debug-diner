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