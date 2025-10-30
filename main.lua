math.randomseed(os.time())


local love = require 'love'


local Snake = {}

Snake.body = { {6, 9}, {5, 9}, {4, 9} }
Snake.direction = {1, 0}
Snake.addSegment = false

function Snake:draw()
    for i = 1, #self.body do
        local x = self.body[i][1]
        local y = self.body[i][2]
        love.graphics.setColor(GREEN)
        love.graphics.rectangle("fill", OFFSET + x * CELL_SIZE, OFFSET + y * CELL_SIZE, CELL_SIZE, CELL_SIZE)
    end
end

function Snake:update()
    -- yay
    table.insert(self.body, 1, Vector2Add(self.body[1], self.direction))
    if not self.addSegment then
        table.remove(self.body)
    else
        self.addSegment = false
    end
end

function Snake:reset()
    self.body = { {6, 9}, {5, 9}, {4, 9} }
    self.direction = {1, 0}
end

function Snake:move(key)
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

local Food = {}
Food.position = {}

function Food:draw()
    love.graphics.setColor(RED)
    love.graphics.rectangle("fill", OFFSET + self.position[1] * CELL_SIZE, OFFSET + self.position[2] * CELL_SIZE, CELL_SIZE, CELL_SIZE)
end

function Food:Generate_random_cell()
    local x = math.random(0, CELL_COUNT - 1)
    local y = math.random(0, CELL_COUNT - 1)
    self.position = {x, y}
    return {x, y}
end

function Food:Generate_random_pos(Vector2_Table_SnakeBody)

    local pos = self:Generate_random_cell()
    while ElementInTable(pos, Vector2_Table_SnakeBody) do
        pos = self:Generate_random_cell()
    end

    self.position = pos
    return pos
end

local game = {
    isRunning = true,
    score = 0,

    draw = function()
        Snake:draw()
        Food:draw()
    end,

    update = function (self)
        Snake:update()
        self:checkCollisionWithFood()
        self:checkCollisionWithEdge()
        self:checkCollisionWithSelf()
    end,

    checkCollisionWithFood = function(self)
        if Vector2Equal(Snake.body[1], Food.position) then
            Snake.addSegment = true
            Food:Generate_random_pos(Snake.body)
            self.score = self.score + 1
            local eat = love.audio.newSource("assets/eat.mp3", "static")
            love.audio.play(eat)
            print("Score: " .. self.score)
        end
    end,

    checkCollisionWithEdge = function(self)
        local head = Snake.body[1]
        if head[1] < 0 or head[1] >= CELL_COUNT or head[2] < 0 or head[2] >= CELL_COUNT then
            self.isRunning = false
            local wall = love.audio.newSource("assets/wall.mp3", "static")
            love.audio.play(wall)
            print("Game Over! Final Score: " .. self.score)
            self:gameover()
        end
    end,

    checkCollisionWithSelf = function(self)
        local headless_body = Snake.body
        table.remove(headless_body, 1)
        for i = 1, #headless_body do
            if Vector2Equal(Food.position, headless_body[i]) then
                self.isRunning = false
                local wall = love.audio.newSource("assets/wall.mp3", "static")
                love.audio.play(wall)
                print("Game Over! Final Score: " .. self.score)
                self:gameover()
            end
        end
    end,
    gameover = function(self)
        Snake:reset()
        Food:Generate_random_pos(Snake.body)
        self.score = 0
        local wall = love.audio.newSource("assets/wall.mp3", "static")
        love.audio.play(wall)
        self.isRunning = false
    end

}

function love.keypressed(key)
    Snake:move(key)
end

function love.load()
    -- local eat = love.audio.newSource("assets/eat.mp3", "static")

    Food:Generate_random_pos(Snake.body)
end

function love.update(dt)

    if not game.isRunning then
        return
    end

    if CheckInterval(0.15) then
        game:update()
    end
end

function love.draw()

    if game.isRunning then
        -- Draw background and border
        love.graphics.setBackgroundColor(0, 0, 0)
        love.graphics.setColor(DARK_GREEN)
        love.graphics.rectangle("line", OFFSET - 5, OFFSET - 5, SCREEN_W - 2 * OFFSET + 10,     SCREEN_H - 2 * OFFSET + 10)

        game:draw()
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Game Over! Press Enter to Restart", 0, SCREEN_H / 2 - 10, SCREEN_W, "center")
        if love.keyboard.isDown("return") then
            game.isRunning = true
            Snake:reset()
            Food:Generate_random_pos(Snake.body)
            game.score = 0
        end
    end

end