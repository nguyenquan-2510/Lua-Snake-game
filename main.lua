math.randomseed(os.time())

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
    elseif key == "down" and self.direction[2] ~= -1 then
        self.direction = {0, 1}
    elseif key == "left" and self.direction[1] ~= 1 then
        self.direction = {-1, 0}
    elseif key == "right" and self.direction[1] ~= -1 then
        self.direction = {1, 0}
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
    finalScore = 0,

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
            self.score = self.score + 1
            Food:Generate_random_pos(Snake.body)
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
        local head = Snake.body[1]
        local body_copy = {}

        for i = 2, #Snake.body do
            table.insert(body_copy, Snake.body[i])
        end

        for i = 1, #body_copy do
            if Vector2Equal(head, body_copy[i]) then
                self.isRunning = false
                local wall = love.audio.newSource("assets/wall.mp3", "static")
                love.audio.play(wall)
                print("Game Over! Final Score: " .. self.score)
                self:gameover()
                return
            end
        end
    end,

    gameover = function(self)
        self.finalScore = self.score
        local wall = love.audio.newSource("assets/wall.mp3", "static")
        love.audio.play(wall)

        self.isRunning = false
        Snake:reset()
        Food:Generate_random_pos(Snake.body)
        self.score = 0

    end


}

function love.keypressed(key)
    Snake:move(key)
    if key == "escape" and not game.isRunning then
        love.event.quit()
    end
end

function love.load()
    -- local eat = love.audio.newSource("assets/eat.mp3", "static")
    font = love.graphics.newFont(30)

    Food:Generate_random_pos(Snake.body)
end

function love.update(dt)
    if not game.isRunning then
        return
    end

    if game.isRunning and CheckInterval(0.2) then
        game:update()
    end
end

function love.draw()

    if game.isRunning then
        -- Draw background and border
        love.graphics.setBackgroundColor(0, 0, 0)
        love.graphics.setColor(DARK_GREEN)
        love.graphics.rectangle("line", OFFSET - 5, OFFSET - 5, SCREEN_W - 2 * OFFSET + 10,     SCREEN_H - 2 * OFFSET + 10)


        -- Score display
        love.graphics.setColor(DARK_GREEN)
        love.graphics.setNewFont(30)
        love.graphics.printf("Score: " .. game.score, OFFSET / 2, OFFSET / 2 - 15, SCREEN_W - OFFSET, "left")

        game:draw()
    else

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(font)

        love.graphics.printf("Final Score: " .. game.finalScore, 0, SCREEN_H / 2 - 40, SCREEN_W, "center")

        love.graphics.printf("Game Over! Press Space to Restart", 0, SCREEN_H / 2 + 40, SCREEN_W, "center")
        if love.keyboard.isDown("space") then
            game.isRunning = true
            Snake:reset()
            Food:Generate_random_pos(Snake.body)
            game.score = 0
        end
    end

end