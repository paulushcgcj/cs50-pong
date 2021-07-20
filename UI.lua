Class = require 'class'

UI = Class{}

function UI:init(fontName,smallSize,mediumSize,largeSize)
    self.smallFont = love.graphics.newFont(fontName,smallSize)
    self.mediumFont = love.graphics.newFont(fontName,mediumSize)
    self.largeFont = love.graphics.newFont(fontName,largeSize)
    love.graphics.setFont(self.smallFont)
end

function UI:update(dt)

end

function UI:renderSmall(text,x,y,limit,align)
    love.graphics.setFont(self.smallFont)
    love.graphics.printf(text,x,y,limit,align)
end

function UI:renderMedium(text,x,y,limit,align)
    love.graphics.setFont(self.mediumFont)
    love.graphics.printf(text,x,y,limit,align)
end

function UI:renderLarge(text,x,y,limit,align)
    love.graphics.setFont(self.largeFont)
    love.graphics.printf(text,x,y,limit,align)
end

function UI:renderSmallFixed(text,x,y)
    love.graphics.setFont(self.smallFont)
    love.graphics.print(text,x,y)
end

function UI:renderMediumFixed(text,x,y)
    love.graphics.setFont(self.mediumFont)
    love.graphics.print(text,x,y)
end

function UI:renderLargeFixed(text,x,y)
    love.graphics.setFont(self.largeFont)
    love.graphics.print(text,x,y)
end