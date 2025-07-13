levels = {
    -- levels are max 10 rows of 8 characters each
    -- {
    --     -- easy clear
    --     "000b0000"
    -- },
    -- {
    --     -- colors
    --     "abcdefgh",
    --     "ijklmnop",
    -- },
    {
        "00000000",
        "b000000b",
        "b0dddd0b",
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
        "0bbbbbb0",
        "00000000",
        "00000000",
        "0bbbbbb0",
        "0b0000b0",
        "0bbbbbb0",
        "00000000"
    },
    {
        "00000000",
        "0bbbbbb0",
        "0b0000b0",
        "0b0000b0",
        "0bbbbbb0",
        "00000000",
        "0eeeeee0",
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
    b = { color = 1 },
    c = { color = 2 }, -- ball color
    d = { color = 3 },
    e = { color = 4 },
    f = { color = 5 },
    g = { color = 6 },
    h = { color = 7 },
    i = { color = 8 }, -- ball color again ?
    j = { color = 9 },
    k = { color = 10 },
    l = { color = 11 },
    m = { color = 12 },
    n = { color = 13 },
    o = { color = 14 },
    p = { color = 15 }
}

game_states = {
    loading = "loading",
    playing = "playing",
    cleared = "cleared",
    won = "won",
    gameover = "gameover"
}

resetting_states = {
    [game_states.loading] = true,
    [game_states.won] = true,
    [game_states.gameover] = true
}