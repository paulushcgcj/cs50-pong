push = require 'lib/push'
require 'src/Paddle'
require 'src/Ball'
require 'src/UI'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

MAX_SCORE = 10

function love.load()

    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Pong by Paulo')
    math.randomseed(os.time())

    ui = UI('fonts/PressStart2P-Regular.ttf',8, 16, 24)

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2,VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    player1Score = 0
    player2Score = 0
    servingPlayer = 1
    winningPlayer = 0

    gameState = 'start'

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
     
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then

        if gameState == 'start' then
            gameState = 'serve'            
        elseif gameState == 'serve' then
            ball:serve(servingPlayer)
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'serve'
            ball:reset()
            player1Score = 0
            player2Score = 0
            
            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

function love.update(dt)
    
    if player1Score == MAX_SCORE or player2Score == MAX_SCORE then
        gameState = 'done'
        winningPlayer = player1Score == MAX_SCORE and 1 or 2
    end

    if gameState == 'play' then

        player1:move('w','s',PADDLE_SPEED)
        player2:move('up','down',PADDLE_SPEED)

        if ball:collides(player1) then            
            ball:paddleHit(player1.x + 5)
            sounds['paddle_hit']:play()
        end
        if ball:collides(player2) then
            ball:paddleHit(player2.x - 4)
            sounds['paddle_hit']:play()
        end

        local topBottom, leftHit, rightHit = ball:update(dt,VIRTUAL_HEIGHT,VIRTUAL_WIDTH)

        if topBottom then
            sounds['wall_hit']:play()
        end

        if leftHit then
            sounds['score']:play()
            gameState = 'serve'
            player2Score = player2Score + 1
            servingPlayer = 1
            ball:reset()
        end

        if rightHit then
            sounds['score']:play()
            gameState = 'serve'
            player1Score = player1Score + 1
            servingPlayer = 2
            ball:reset()
        end

        player1:update(dt,VIRTUAL_HEIGHT)
        player2:update(dt,VIRTUAL_HEIGHT)

    end

    
end

function love.draw()
    push:start()
    
    
    if gameState == 'start' then
        ui:renderSmall('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        ui:renderSmall('Press ENTER to start', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        ui:renderSmall('Player ' .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        ui:renderSmall('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
        basicDraw()
    elseif gameState == 'play' then
        basicDraw()
        --Ball
        ball:render()
    elseif gameState == 'done' then
        ui:renderLarge('Player ' .. tostring(winningPlayer) .. ' wins!',0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
        ui:renderSmall('Press Enter to restart!', 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')
    end

    --Debug
    ui:renderSmallFixedColor(gameState, VIRTUAL_WIDTH-40, VIRTUAL_HEIGHT - 10)
    ui:displayFPS(VIRTUAL_HEIGHT)

    push:finish()
end

function basicDraw()
    --Score
    ui:renderLargeFixed(tostring(player1Score), 40, 5)
    ui:renderLargeFixed(tostring(player2Score), VIRTUAL_WIDTH - 70, 5)

    --Players
    player1:render()
    player2:render()
    
end