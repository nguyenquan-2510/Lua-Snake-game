
local love = require 'love'

local snake = {}

snake.body = { {6, 9}, {5, 9}, {4, 9} }
snake.direction = {1, 0}
snake.addSegment = false

function snake:draw()
    for i = 1, #self.body do
        local x = self.body[i][1]
        local y = self.body[i][2]
        love.graphics.setColor(GREEN)
        love.graphics.rectangle("fill", OFFSET + x * CELL_SIZE, OFFSET + y * CELL_SIZE, CELL_SIZE, CELL_SIZE)
    end
end

function snake:update()
    -- yay
    table.insert(self.body, 1, Vector2Add(self.body[1], self.direction))
    if not self.addSegment then
        table.remove(self.body)
    else
        self.addSegment = false
    end
end

function snake:reset()
    self.body = { {6, 9}, {5, 9}, {4, 9} }
    self.direction = {1, 0}
end

function snake:move(key)
    if key == "up" and self.direction[2] ~= 1 then
        self.direction = {0, -1}
        print(self.direction[1], self.direction[2])
    elseif key == "down" and self.direction[2] ~= -1 then
        self.direction = {0, 1}
        print(self.direction[1], self.direction[2])
    elseif key == "left" and self.direction[1] ~= 1 then
        self.direction = {-1, 0}
        print(self.direction[1], self.direction[2])
    elseif key == "right" and self.direction[1] ~= -1 then
        self.direction = {1, 0}
        print(self.direction[1], self.direction[2])
    end
end

local game = {
    isRunning = true
}


function love.keypressed(key)
    snake:move(key)
end

function love.load()
    local eat = love.audio.newSource("assets/eat.mp3", "static")
    local wall = love.audio.newSource("assets/wall.mp3", "static")
end

function love.update(dt)

    if game.isRunning and CheckInterval(0.1) then
        snake:update()
    end
end

function love.draw()

    -- Draw background and border
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(DARK_GREEN)
    love.graphics.rectangle("line", OFFSET - 5, OFFSET - 5, SCREEN_W - 2 * OFFSET + 10, SCREEN_H - 2 * OFFSET + 10)

    snake:draw()
end