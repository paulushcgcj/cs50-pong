Class = require 'lib/class'
require 'src/states/BaseState'

GameOverState = Class{__includes = BaseState}

function GameOverState:init(screenWidth,screenHeight)
    self.screenWidth = screenWidth
    self.screenHeight = screenHeight
    self.winningPlayer = 0
end

function GameOverState:enter(params)
    self.winningPlayer = params.winningPlayer
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.mouse.wasPressed(1) then
        gStateMachine:change('serve',{
            servingPlayer = self.winningPlayer,
            player1Score = 0,
            player2Score = 0
        })
    end
end

function GameOverState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Player ' .. tostring(self.winningPlayer) .. ' wins!',0, self.screenHeight / 2, self.screenWidth, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to restart!', 0, self.screenHeight / 2 + 90, self.screenWidth, 'center')
end