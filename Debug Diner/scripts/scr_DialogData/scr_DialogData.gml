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
				DialogLine("R", "???", "AGH!", spr_Portrait_Right),
				DialogLine("L", "Player", "Uh...", spr_Portrait_Left),
				DialogLine("L", "Player", "...", spr_Portrait_Left),
				DialogLine("L", "Player", "Who are you...", spr_Portrait_Left),
				DialogLine("L", "Player", "...and why are you in my backyard?!", spr_Portrait_Left),
				DialogLine("R", "???", "I knew that manuver would be too ti-", spr_Portrait_Right),
				DialogLine("R", "???", "...", spr_Portrait_Right),
				DialogLine("R", "???", "Say that again?", spr_Portrait_Right),
				DialogLine("L", "Player", "I said, who are y-", spr_Portrait_Left),
				DialogLine("R", "???", "Oh thank the mothership! I thought I missed Terra by a solar system!", spr_Portrait_Right),
				DialogLine("L", "Player", "Wha-", spr_Portrait_Left),
				DialogLine("R", "???", "Wait! Give me a moment...", spr_Portrait_Right),
				DialogLine("L", "Player", "?", spr_Portrait_Left),
				DialogLine("R", "???", "...", spr_Portrait_Right),
				DialogLine("R", "???", "AHA! It is English you speak... Correct?", spr_Portrait_Right),
				DialogLine("L", "Player", "Uh... Yes?", spr_Portrait_Left),
				DialogLine("L", "Player", "MORE DIALOGUE TO COME", spr_Portrait_Left),
				DialogLine("R", "???", "Go ahead and use that robot to complete the task posted on the hologram to your right!", spr_Portrait_Right),
				DialogLine("R", "???", "Oh, and make sure not to crash it... I suspect that the robots will be quite fragile after that emergency landing!", spr_Portrait_Right),
            ];
		
		case rm_Level1_2:
			return [
				DialogLine("L", "Player", "...", spr_Portrait_Left),
				DialogLine("L", "Player", "Why do you have so many tables?", spr_Portrait_Left),
				DialogLine("R", "???", "Because I'm going to open a planet-famous diner right here in Terra!", spr_Portrait_Right),
				DialogLine("R", "???", "Don't worry, I've reserved the head chef position for you!", spr_Portrait_Right),
				DialogLine("L", "Player", "But I don't even know how to cook...", spr_Portrait_Left),
				DialogLine("R", "???", "If that's the case...", spr_Portrait_Right),
				DialogLine("R", "???", "You better learn how to program!", spr_Portrait_Right),
			];

        default:
            return [];
    }
}