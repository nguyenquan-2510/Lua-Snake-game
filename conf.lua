local love = require 'love'

-- Variables
GREEN = {0, 1, 0}
DARK_GREEN = {173 / 255, 204 / 255, 96 / 255, 255 / 255}
RED = {1, 0, 0}
CELL_SIZE = 30
CELL_COUNT = 25
OFFSET = 75
SCREEN_W = CELL_SIZE * CELL_COUNT + OFFSET * 2
SCREEN_H = CELL_SIZE * CELL_COUNT + OFFSET * 2
LAST_UPDATE_TIME = 0
------------
-- My Custom Functions Here !

-- Add 2 Vector2
function Vector2Add(Vector2_A, Vector2_B)
    if #Vector2_A ~= 2 or #Vector2_B ~= 2 then
        error("Both parameters must be Vector2")
    end
    return { Vector2_A[1] + Vector2_B[1], Vector2_A[2] + Vector2_B[2] }
end

-- Check interval function
function CheckInterval(interval)
    local CurentTime = love.timer.getTime()

    if CurentTime - LAST_UPDATE_TIME >= interval then
        LAST_UPDATE_TIME = CurentTime
        return true
    end
    return false
end
------------





function love.conf(t)
    t.console = true
    t.window.width = SCREEN_W
    t.window.height = SCREEN_H
    t.window.title = "Snake Game - Lua x LOVE2D"
end