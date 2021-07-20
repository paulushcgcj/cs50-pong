Class = require 'class'

Ball = Class{}

function Ball:init(x,y,width,height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.deltaX = math.random(2) == 1 and 100 or -100
    self.deltaY = math.random(-50,50)
end

function Ball:update(dt)
    self.deltaX = self.x + self.deltaX * dt
    self.deltaY = self.y + self.deltaY * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end