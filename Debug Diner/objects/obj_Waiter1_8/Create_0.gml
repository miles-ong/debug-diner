event_inherited();

program = [
    {
        type: BlockType.LOOP,
        args: { count: 100 },
        body: [
            { type: BlockType.TURN, args: { turnDirection: 1 }, body: [], isDraggable: false }
        ],
        isDraggable: false
    }
];