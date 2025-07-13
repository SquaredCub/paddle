function _init()
    x_edge = 127 - 16
    hit = 0
    game_state = game_states.loading
    current_lvl = 1
    brick_width = 15
    brick_height = 8

    function draw_start()
        center_text("press ❎ to start", 62)
    end
    function draw_paddle()
        spr(1, paddle.x, 120)
        spr(2, paddle.x + 8, 120)
    end
    function draw_clear()
        center_text("level cleared!", 62, 11)
        center_text("press ❎ to continue", 74)
    end
    function draw_gameover()
        center_text("game over", 62, 2)
        center_text("press ❎ to restart", 74)
    end
    function draw_win()
        center_text("you win!", 62, 11)
        center_text("press ❎ to restart", 74)
    end

    paddle = {
        x = 0,
        speed = 2,
        length = 16
    }

    function reset_ball()
        ball = {
            x = 64,
            y = 120,
            dx = 0,
            dy = -1,
            radius = 2
        }
    end

    load_level(1)
    reset_ball()
end

function _update60()
    -- starting game
    if btn(❎) then
        if resetting_states[game_state] then
            current_lvl = 1
            load_level(current_lvl)
            reset_ball()
            game_state = game_states.playing
        end
        if game_state == game_states.cleared then
            current_lvl += 1
            load_level(current_lvl)
            reset_ball()
            game_state = game_states.playing
        end
    end

    -- controls
    if btn(➡️) then
        paddle.x = clamp(paddle.x + paddle.speed, 1, x_edge)
    elseif btn(⬅️) then
        paddle.x = clamp(paddle.x - paddle.speed, 1, x_edge)
    end

    -- ball
    if game_state == game_states.playing then
        -- predictive brick collision
        local next_x = ball.x + ball.dx
        local next_y = ball.y + ball.dy

        for b in all(bricks) do
            if next_x + ball.radius >= b.x
                    and next_x - ball.radius <= b.x + b.w
                    and next_y + ball.radius >= b.y
                    and next_y - ball.radius <= b.y + b.h then
                local collided_vertically = ball.y + ball.radius <= b.y
                        or ball.y - ball.radius >= b.y + b.h

                if collided_vertically then
                    ball.dy = -ball.dy
                else
                    ball.dx = -ball.dx
                end

                sfx(0)
                del(bricks, b)
                break
            end
        end

        -- bounce off left/right walls
        if next_x < ball.radius + 1 or next_x > 127 - ball.radius + 1 then
            ball.dx = -ball.dx
        end
        -- bounce off top
        if next_y < ball.radius + 1 then
            ball.dy = -ball.dy
        end

        -- paddle bounce
        if next_x >= paddle.x and next_x <= paddle.x + paddle.length and next_y + ball.radius >= 123 then
            hit_pos = (ball.x - paddle.x) / paddle.length
            angle = clamp(0.5 * (1 - hit_pos), 0.1, 0.4)
            speed = sqrt(ball.dx ^ 2 + ball.dy ^ 2)
            ball.dx = cos(angle) * speed
            ball.dy = -abs(sin(angle)) * speed
            sfx(1)
        end

        -- stops game if bounces on bottom
        if ball.y > 128 - ball.radius then
            game_state = game_states.gameover
        end

        -- move ball
        ball.x += ball.dx
        ball.y += ball.dy

        if #bricks == 0 then
            if current_lvl < #levels then
                game_state = game_states.cleared
            else
                game_state = game_states.won
            end
        end
    end
end

function _draw()
    cls()
    -- border
    rect(0, 0, 127, 128, 6)
    -- debug

    -- print("level " .. current_lvl, 2, 2, 7)
    -- print("game state: " .. game_state, 2, 10, 7)
    -- if btn(❎) then
    --  print("❎ pressed", 2, 18, 7)
    -- end

    if game_state == game_states.loading then
        draw_start()
    elseif game_state == game_states.playing then
        for b in all(bricks) do
            drw_brick(b.x, b.y, b.color)
        end
        draw_paddle()
        circfill(ball.x, ball.y, ball.radius, 8)
    elseif game_state == game_states.cleared then
        draw_clear()
    elseif game_state == game_states.won then
        draw_win()
    elseif game_state == game_states.gameover then
        draw_gameover()
    end
end