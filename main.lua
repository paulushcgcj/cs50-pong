push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Ball'
require 'UI'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('Pong by Paulo')

    math.randomseed(os.time())

    ui = UI('PressStart2P-Regular.ttf',8, 22, 32)
    

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2,VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    player1Score = 0
    player2Score = 0
    
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2


    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50,50)


    gameState = 'start'


    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50,50) * 1.5
        end
    end
end

function love.update(dt)
    player1:move('w','s',PADDLE_SPEED)
    player2:move('up','down',PADDLE_SPEED)

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt,VIRTUAL_HEIGHT)
    player2:update(dt,VIRTUAL_HEIGHT)
end

function love.draw()
    push:apply('start')
    
    --Game Text    
    if gameState == 'start' then
        ui:renderSmall('Press ENTER to start', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        --Score
        ui:renderLargeFixed(tostring(player1Score), 40, 5)
        ui:renderLargeFixed(tostring(player2Score), VIRTUAL_WIDTH - 70, 5)
    end

    
    --Players
    player1:render()
    player2:render()

    --Ball
    ball:render()

    push:apply('end')
end
