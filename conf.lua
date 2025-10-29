local love = require 'love'

SIU = "Hello, Snake Game!"
GREEN = {173 / 255, 204 / 255, 96 / 255, 255 / 255}

function love.conf(t)
    t.console = false
    t.window.width = 750 + 75
    t.window.height = 750 + 75
    t.window.title = "Snake Game - Lua x LOVE2D"
end