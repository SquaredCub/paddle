brick_width = 16
brick_height = 6
widener_width = 4
default_paddle_width = 16

levels = {
    -- levels are max 10 rows of 8 characters each
    -- {
    --     -- easy clear
    --     "000kb000"
    -- },
    -- {
    --     -- colors
    --     "abcdefgh",
    --     "ijklmnop",
    -- },
    {
        "00000000",
        "0aaaaaa0",
        "0a0000a0",
        "0aaaaaa0",
        "00000000",
        "00000000",
        "0bbbcbb0",
        "0b0000b0",
        "0bbbbbb0",
        "00000000"
    },
    {
        "00000000",
        "b000000b",
        "b0dcdd0b",
        "b000000b",
        "00bbbb00",
        "00bbbb00",
        "b000000b",
        "b0dddd0b",
        "b000000b",
        "00000000"
    },
    {
        "00000000",
        "0bbbbbb0",
        "0b0000b0",
        "0b0000b0",
        "0bbbbbb0",
        "00000000",
        "0eeccee0",
        "0e0ee0e0",
        "0e0ee0e0",
        "00000000"
    },
    {
        "00000000",
        "00000000",
        "0eee0ff0",
        "00e00f00",
        "00e00f00",
        "00e00f00",
        "00e00f00",
        "0ee00ff0"
    }
}

bricks_register = {
    a = { color = 15, shadow = 4 },
    b = { color = 9, shadow = 5 },
    c = { color = 11, shadow = 3, bonus = "widener" },
    d = { color = 12, shadow = 13 },
    e = { color = 6, shadow = 13 },
    f = { color = 14, shadow = 2 }
}

bonuses_register = {
    widener = { w = 8, h = 5, sprite = 7 }
}

game_states = {
    loading = "loading",
    playing = "playing",
    cleared = "cleared",
    won = "won",
    gameover = "gameover",
    paused = "paused"
}

resetting_states = {
    [game_states.loading] = true,
    [game_states.won] = true,
    [game_states.gameover] = true
}