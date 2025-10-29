local System = {
    Color = {
        Green = {173 / 255, 204 / 255, 96 / 255, 255 / 255},
        Dark_Green = {43 / 255, 51 / 255, 24 / 255, 255 / 255}
    },

    Screen = {
        Width = 750,
        Height = 750,
    },

    CellSize = 30,
    CellCount = 25,

    offset = 75,

    running = true,
    score = 0,

    CustomFunction = {
        Vector2Add = function (Vector2_a, Vector2_b)

            Vector2_a = Vector2_a or {0, 0}
            Vector2_b = Vector2_b or {0, 0}

            if #Vector2_a > 2 or #Vector2_b > 2 then
                return function ()
                    print("Unable to add 2 vector2 vectors !! Pls check again.")
                end
            end

            return { Vector2_a[1] + Vector2_b[1], Vector2_a[2] + Vector2_b[2] }
        end
    },

    SoundPath = {
        Eat = "assets/eat.mp3",
        Wall = "assets/wall.mp3"
    }
}

return System