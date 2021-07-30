Class = require 'lib/class'
require 'src/states/BaseState'
require 'src/Paddle'
require 'src/Ball'


PlayState = Class{__includes = BaseState}

function PlayState:init(screenWidth,screenHeight)
    self.screenHeight = screenHeight
    self.screenWidth = screenWidth
    self.servingPlayer = 1
    self.player1Score = 0
    self.player2Score = 0

    self.player1 = Paddle(10, 30, 5, 20)
    self.player2 = Paddle(self.screenWidth - 10, 30, 5, 20)
    self.ball = Ball(self.screenWidth / 2 - 2,self.screenHeight / 2 - 2, 4, 4)
end

function PlayState:enter(params)
    self.servingPlayer = params.servingPlayer
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score

    self.ball:reset()
    self.ball:serve(self.servingPlayer)
end

function PlayState:update(dt)
    self.player1:move('w','s',PADDLE_SPEED)
    self.player2:move('up','down',PADDLE_SPEED)

    if self.ball:collides(self.player1) then            
        self.ball:paddleHit(self.player1.x + 5)
        sounds['paddle_hit']:play()
    end
    if self.ball:collides(self.player2) then
        self.ball:paddleHit(self.player2.x - 4)
        sounds['paddle_hit']:play()
    end

    local topBottom, leftHit, rightHit = self.ball:update(dt,self.screenHeight,self.screenWidth)

    if topBottom then
        sounds['wall_hit']:play()
    end

    if leftHit then
        sounds['score']:play()
        self.servingPlayer = 1
        self.player2Score = self.player2Score + 1
    end

    if rightHit then
        sounds['score']:play()
        self.servingPlayer = 2
        self.player1Score = self.player1Score + 1
    end


    if rightHit or leftHit then
        gStateMachine:change('serve',{
            servingPlayer = self.servingPlayer,
            player1Score = self.player1Score,
            player2Score = self.player2Score
        })
    end

    self.player1:update(dt,self.screenHeight)
    self.player2:update(dt,self.screenHeight)
end

function PlayState:render()
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(self.player1Score), 40, 5)
    love.graphics.print(tostring(self.player2Score), self.screenWidth - 70, 5)
    self.player1:render()
    self.player2:render()
    self.ball:render()
end