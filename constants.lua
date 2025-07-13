brick_width = 15
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
        "0mmmmmm0",
        "0m0000m0",
        "0mmmmmm0",
        "00000000",
        "00000000",
        "0bbbkbb0",
        "0b0000b0",
        "0bbbbbb0",
        "00000000"
    },
    {
        "00000000",
        "b000000b",
        "b0dkdd0b",
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
        "0eekkee0",
        "0e0ee0e0",
        "0e0ee0e0",
        "00000000"
    },
    {
        "00000000",
        "00000000",
        "0jjj0cc0",
        "00j00c00",
        "00j00c00",
        "00j00c00",
        "00j00c00",
        "0jj00cc0"
    }
}

bricks_register = {
    a = { color = 0 }, -- invisible
    b = { color = 1 }, -- blue
    c = { color = 2 }, -- ball color
    d = { color = 3 },
    e = { color = 4 },
    f = { color = 5 }, -- grey
    g = { color = 6 },
    h = { color = 7 }, --white
    i = { color = 8 }, -- ball color again ?
    j = { color = 9 }, -- pink
    k = { color = 10, bonus = "widener" }, -- yellow
    l = { color = 11 }, -- lime green
    m = { color = 12 }, -- light blue
    n = { color = 13 },
    o = { color = 14 },
    p = { color = 15 }
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