Class = require 'lib/class'

Ball = Class{}

function Ball:init(x,y,width,height)
    self.startX = x
    self.startY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.deltaX = 0
    self.deltaY = 0
end

function Ball:update(dt,screenHeight,screenWidth)
    self.x = self.x + self.deltaX * dt
    self.y = self.y + self.deltaY * dt

    local topBottomHit = false
    local leftHit = false
    local rightHit = false

    --Top or Bottom Hit
    if self.y <= 0 then
        self.y = 0
        self.deltaY = -self.deltaY
        topBottomHit = true
    end

    if self.y >= screenHeight - self.height then
        self.y = screenHeight - self.height
        self.deltaY = -self.deltaY
        topBottomHit = true
    end

    leftHit = self.x < 0
    rightHit = self.x > screenWidth

    return topBottomHit, leftHit, rightHit

end

function Ball:collides(target)

    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end
    return true
end

function Ball:paddleHit(paddleX)
    self.deltaX = -self.deltaX * 1.03
    self.x = paddleX

    if self.deltaY < 0 then
        self.deltaY = -math.random(10, 150)
    else
        self.deltaY = math.random(10, 150)
    end
end

function Ball:reset()
    self.x = self.startX
    self.y = self.startY
    self.deltaX = 0
    self.deltaY = 0
end

function Ball:serve(playerServe)
    self.deltaY = math.random(-50,50)
    self.deltaX = playerServe == 1 and math.random(140, 200) or -math.random(140, 200)
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:toString()
    local s = "Ball["
    for key, value in pairs(ball) do
        s = s..key..":"..value..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end