Class = require 'lib/class'

Paddle = Class{}

function Paddle:init(x,y,width,height)
    self.startX = x
    self.startY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt,screenHeight)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(screenHeight - self.height, self.y + self.dy * dt)
    end
    self.dy = 0

    for index, data in ipairs(self) do
        for key, value in pairs(data) do
            print('\t', key, value)
        end
    end
end

function Paddle:move(upKey,downKey,speed)
    if love.keyboard.isDown(upKey) then
        self.dy = -speed
    elseif love.keyboard.isDown(downKey) then
        self.dy = speed
    end
end

function Paddle:reset()
    self.x = self.startX
    self.y = self.startY
    self.dy = 0
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:toString()
    local s = "Paddle["
    for key, value in pairs(self) do
        s = s..key..":"..value..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end