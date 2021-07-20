push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest','nearest')

    smallFont = love.graphics.newFont('PressStart2P-Regular.ttf',8)

    scoreFont = love.graphics.newFont('PressStart2P-Regular.ttf',32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

end

function love.keypressed(key)
    if key == 'espace' then
        love.event.quit()
    end
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

function love.draw()
    push:apply('start')

    --It messes everything
    --love.graphics.clear(40,45,52,255)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 90, 5)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 70, 5)


    --Left Paddle
    love.graphics.rectangle('fill',10,player1Y,5,20)

    --Right Paddle
    love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10,player2Y,5,20)

    --Ball
    love.graphics.rectangle('fill',VIRTUAL_WIDTH / 2-2,VIRTUAL_HEIGHT / 2 - 2,4,4)

    push:apply('end')
end
