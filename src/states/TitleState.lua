Class = require 'lib/class'
require 'src/states/BaseState'

TitleState = Class{__includes = BaseState}

function TitleState:init(screenWidth)
    self.screenWidth = screenWidth
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.mouse.wasPressed(1) then
        gStateMachine:change('serve',{
            servingPlayer = 1,
            player1Score = 0,
            player2Score = 0
        })
    end
end

function TitleState:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Welcome to Pong!', 0, 10, self.screenWidth, 'center')
    love.graphics.printf('Press ENTER to start', 0, 20, self.screenWidth, 'center')
end