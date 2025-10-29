
local love = require 'love'
local System = require 'system'
local snake = require 'snake'
local food = require 'food'

function love.load()
    eat = love.audio.newSource(System.SoundPath.Eat, "static")
    wall = love.audio.newSource(System.SoundPath.Wall, "static")
end

function love.update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(System.Color.Green)
    snake:Draw()
end