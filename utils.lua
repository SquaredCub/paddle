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
                        x = (col - 1) * brick_width + 4,
                        y = (row - 1) * brick_height + 4,
                        w = brick_width,
                        h = brick_height,
                        color = bricks_register[ch].color
                    }
                )
            end
        end
    end
end

function rect_rect_collision(r1, r2)
    return r1.x < r2.x + r2.w
            and r1.x + r1.w > r2.x
            and r1.y < r2.y + r2.h
            and r1.y + r1.h > r2.y
end

function drw_brick(x, y, color)
    pal(7, color)
    spr(3, x, y)
    spr(4, x + 8, y)
    pal()
end

function center_text(text, y, color)
    local w = #text * 4
    print(text, (128 - w) / 2, y, color or 7)
end