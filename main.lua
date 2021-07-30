push = require 'lib/push'

require 'src/StateMachine'
require 'src/states/PlayState'
require 'src/states/TitleState'
require 'src/states/GameOverState'
require 'src/states/ServeState'

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

    smallFont = love.graphics.newFont('fonts/PressStart2P-Regular.ttf',8)
    mediumFont = love.graphics.newFont('fonts/PressStart2P-Regular.ttf',16)
    largeFont = love.graphics.newFont('fonts/PressStart2P-Regular.ttf',24)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState(VIRTUAL_WIDTH) end,
        ['play'] = function() return PlayState(VIRTUAL_WIDTH,VIRTUAL_HEIGHT) end,
        ['gameover'] = function () return GameOverState(VIRTUAL_WIDTH,VIRTUAL_HEIGHT) end,
        ['serve'] = function () return ServeState(VIRTUAL_WIDTH,10) end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end

function love.mousepressed(x,y,button)
    love.mouse.buttonsPressed[button] = true
    love.mouse.position = {x = x, y = y}
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(key)
    return love.mouse.buttonsPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end