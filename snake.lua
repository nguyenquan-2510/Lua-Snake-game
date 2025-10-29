local love = require 'love'
local Sys = require 'system'

local snake = {
    body = { {6, 9}, {5, 9}, {4, 9} },
    direction = {1, 0},
    addSegment = false,

    Draw = function (self)
        for i = 1, #self.body, 1 do
            local x = self.body[i][1]
            local y = self.body[i][2]

            love.graphics.setColor(Sys.Color.Dark_Green)
            love.graphics.rectangle("fill", Sys.offset + x * Sys.CellSize, Sys.offset + y * Sys.CellSize, Sys.CellSize, Sys.CellSize)
        end
    end
}

return snake