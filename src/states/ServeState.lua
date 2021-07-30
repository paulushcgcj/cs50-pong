Class = require 'lib/class'
require 'src/states/BaseState'

ServeState = Class{__includes = BaseState}

function ServeState:init(screenWidth,maxScore)
    self.screenWidth = screenWidth
    self.servingPlayer = 1
    self.player1Score = 0
    self.player2Score = 0
    self.maxScore = maxScore
end

function ServeState:enter(params)
    self.servingPlayer = params.servingPlayer
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function ServeState:update(dt)

    if self.player1Score == self.maxScore or self.player2Score == self.maxScore then
        gStateMachine:change('gameover',{ winningPlayer = self.player1Score == self.maxScore and 1 or 2 })
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.mouse.wasPressed(1) then

        gStateMachine:change('play',{
            player1Score = self.player1Score,
            player2Score = self.player2Score,
            servingPlayer = self.servingPlayer
        })
    end

end

function ServeState:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Player ' .. tostring(self.servingPlayer) .. "'s serve!", 0, 10, self.screenWidth, 'center')
    love.graphics.printf('Press Enter to serve!', 0, 20, self.screenWidth, 'center')
end