function _init()
    game_state = game_states.loading
    current_lvl = 1

    bonuses = {}

    function draw_start()
        center_text("press ❎ to start", 62)
    end
    function draw_paddle()
        spr(1, paddle.x, paddle.y)
        rectfill(paddle.x + 2, paddle.y, paddle.x + paddle.w - 2, paddle.y + paddle.h, 9)
        spr(2, paddle.x + paddle.w - 2, paddle.y)
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

    function reset_paddle(hard)
        if hard then
            paddle = {
                -- x = 64 - default_paddle_width / 2 + 2,
                x = 64 - default_paddle_width / 2 - 4, --bug to be fixed
                y = 124,
                w = 16,
                h = 4,
                speed = 2
            }
        else
            paddle.x = 64 - paddle.w / 2 + 2
        end
    end
    function reset_ball()
        ball = {
            x = 64,
            y = 120,
            dx = 0,
            dy = -1,
            r = 2.5
        }
    end

    load_level(1)
    reset_ball()
    reset_paddle(true)
end

function _update60()
    handle_inputs()
    local next_ball = {
        x = ball.x + ball.dx,
        y = ball.y + ball.dy,
        r = ball.r
    }

    -- ball
    if game_state == game_states.playing then
        for b in all(bricks) do
            if sphere_rect_collision(next_ball, b) then
                -- game_state = game_states.paused
                local collided_vertically = ball.y + ball.r <= b.y
                        or ball.y - ball.r >= b.y + b.h

                if collided_vertically then
                    ball.dy = -ball.dy
                else
                    ball.dx = -ball.dx
                end

                if b.bonus == "widener" then
                    spawn_bonus(b.x + b.w / 2, b.y + b.h / 2, b.bonus)
                end

                sfx(0)
                del(bricks, b)
                break
            end
        end

        -- bounce off left/right walls
        if next_ball.x < next_ball.r or next_ball.x + next_ball.r >= 128 then
            ball.dx = -ball.dx
            sfx(2)
        end
        -- bounce off top
        if next_ball.y < next_ball.r then
            ball.dy = -ball.dy
            sfx(2)
        end

        -- paddle bounce
        if sphere_rect_collision(next_ball, paddle) then
            hit_pos = (next_ball.x - paddle.x) / paddle.w
            angle = clamp(0.5 * (1 - hit_pos), 0.1, 0.4)
            speed = sqrt(ball.dx ^ 2 + ball.dy ^ 2)
            ball.dx = cos(angle) * speed
            ball.dy = -abs(sin(angle)) * speed
            sfx(1)
        end

        -- stops game if bounces on bottom
        if next_ball.y > 128 - next_ball.r then
            game_state = game_states.gameover
            sfx(3)
        end

        -- move bonuses
        for b in all(bonuses) do
            -- if bonus goes off screen, remove it
            if b.y > 128 then
                del(bonuses, b)
            end

            if rect_rect_collision(b, paddle) then
                if b.type == "widener" then
                    local new_width = min(paddle.w + widener_width, 32)
                    paddle.x -= max(new_width / 2 - paddle.w / 2, 1)
                    paddle.x = max(paddle.x, 1) -- min x
                    paddle.w = new_width
                    sfx(5)
                end
                del(bonuses, b)
            end

            -- move bonus down
            b.y += 1
        end

        if #bricks == 0 then
            if current_lvl < #levels then
                game_state = game_states.cleared
                sfx(5)
            else
                game_state = game_states.won
                sfx(4)
            end
        end

        -- move ball
        ball.x += ball.dx
        ball.y += ball.dy
    end
end

function _draw()
    cls()
    -- border
    rectfill(0, 0, 128, 128, 1)
    -- debug

    -- print("level " .. current_lvl, 2, 2, 7)
    -- print("game state: " .. game_state, 2, 10, 7)
    -- print("bonus count: " .. #bonuses, 2, 18, 7)
    -- if btn(❎) then
    --  print("❎ pressed", 2, 18, 7)
    -- end

    if game_state == game_states.loading then
        draw_start()
    elseif game_state == game_states.playing or game_state == game_states.paused then
        for b in all(bricks) do
            drw_brick(b)
        end
        for b in all(bonuses) do
            spr(bonuses_register[b.type].sprite, b.x, b.y)
        end
        draw_paddle()
        circfill(ball.x, ball.y, ball.r, 8)
    elseif game_state == game_states.cleared then
        draw_clear()
    elseif game_state == game_states.won then
        draw_win()
    elseif game_state == game_states.gameover then
        draw_gameover()
    end
end