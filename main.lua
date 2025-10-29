
local love = require 'love'

function love.load()
    eat = love.audio.newSource("assets/eat.mp3", "static")
    wall = love.audio.newSource("assets/wall.mp3", "static")
end

function love.update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(GREEN)
end

print(SIU)