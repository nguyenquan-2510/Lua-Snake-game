
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
    return { Vector2_A[1] + Vector2_B[1], Vector2_A[2] + Vector2_B[2] }
end

-- Compare 2 vectors
function Vector2Equal(Vector2_A, Vector2_B)
    return Vector2_A[1] == Vector2_B[1] and Vector2_A[2] == Vector2_B[2]
end

-- Element in table
function ElementInTable(Vector2_Element, Vector2_Table)
    for i = 1, #Vector2_Table do
        if Vector2Equal(Vector2_Element, Vector2_Table[i]) then
            return true
        end
    end
    return false
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
    t.console = false
    t.window.width = SCREEN_W
    t.window.height = SCREEN_H
    t.window.title = "Snake Game - Lua x LOVE2D"
end