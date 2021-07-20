push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()

    love.graphics.setDefaultFilter('nearest','nearest')

    smallFont = love.graphics.newFont('PressStart2P-Regular.ttf',8)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

function love.keypressed(key)
    if key == 'espace' then
        love.event.quit()
    end
end

function love.update(dt)

end

function love.draw()
    push:apply('start')

    --It messes everything
    --love.graphics.clear(40,45,52,255)

    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')


    --Left Paddle
    love.graphics.rectangle('fill',10,30,5,20)

    --Right Paddle
    love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10,VIRTUAL_HEIGHT - 50,5,20)

    --Ball
    love.graphics.rectangle('fill',VIRTUAL_WIDTH / 2-2,VIRTUAL_HEIGHT / 2 - 2,4,4)

    push:apply('end')
end
