local love = require 'love'

-- Variables
SIU = "Hello, Snake Game!"
GREEN = {173 / 255, 204 / 255, 96 / 255, 255 / 255}
DARK_GREEN = {101 / 255, 140 / 255, 43 / 255, 255 / 255}
CELL_SIZE = 30
CELL_COUNT = 25
OFFSET = 75
SCREEN_W = CELL_SIZE * CELL_COUNT + OFFSET
SCREEN_H = CELL_SIZE * CELL_COUNT + OFFSET
------------

function love.conf(t)
    t.console = false
    t.window.width = SCREEN_W
    t.window.height = SCREEN_H
    t.window.title = "Snake Game - Lua x LOVE2D"
end