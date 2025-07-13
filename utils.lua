function mergeTables(a, b)
    local result = {}
    for k, v in pairs(a) do
        result[k] = v
    end
    for k, v in pairs(b) do
        result[k] = v
    end
    return result
end

function clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

function load_level(index)
    cls()
    print("loading level " .. index)
    local layout = levels[index]
    bricks = {}

    for row = 1, #layout do
        for col = 1, #layout[row] do
            local ch = sub(layout[row], col, col)
            if ch ~= "0" then
                add(
                    bricks, {
                        x = (col - 1) * brick_width,
                        y = (row - 1) * brick_height + 4,
                        w = brick_width,
                        h = brick_height,
                        color = bricks_register[ch].color,
                        shadow = bricks_register[ch].shadow,
                        bonus = bricks_register[ch].bonus
                    }
                )
            end
        end
    end
end

function drw_brick(b)
    pal(5, b.shadow or 5)
    pal(6, b.color)
    spr(11, b.x, b.y)
    spr(12, b.x + (b.w / 2), b.y)
    pal()
    -- if b.bonus then
    --     print("🐱", b.x + (b.w / 2) - 3, b.y, 0)
    -- end
end

function center_text(text, y, color)
    local w = #text * 4
    print(text, (128 - w) / 2, y, color or 7)
end

function handle_inputs()
    -- starting game
    if btn(❎) then
        if resetting_states[game_state] then
            current_lvl = 1
            load_level(current_lvl)
            reset_ball()
            reset_paddle(true)
            game_state = game_states.playing
        end
        if game_state == game_states.cleared then
            current_lvl += 1
            load_level(current_lvl)
            reset_ball()
            reset_paddle()
            game_state = game_states.playing
        end
        if game_state == game_states.paused then
            game_state = game_states.playing
        end
    end

    -- controls
    if btn(➡️) then
        paddle.x = clamp(paddle.x + paddle.speed, 0, 128 - paddle.w)
    elseif btn(⬅️) then
        paddle.x = clamp(paddle.x - paddle.speed, 0, 128 - paddle.w)
    end
end

function spawn_bonus(x, y, type)
    local bonus = {
        x = x,
        y = y,
        type = type
    }
    add(bonuses, mergeTables(bonus, bonuses_register[type]))
end

function rect_rect_collision(r1, r2)
    return r1.x < r2.x + r2.w
            and r1.x + r1.w > r2.x
            and r1.y < r2.y + r2.h
            and r1.y + r1.h > r2.y
end

function sphere_rect_collision(sphere, rect)
    return sphere.x + sphere.r >= rect.x
            and sphere.x - sphere.r <= rect.x + rect.w
            and sphere.y + sphere.r >= rect.y
            and sphere.y - sphere.r <= rect.y + rect.h
end