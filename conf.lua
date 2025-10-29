local love = require 'love'
local System = require 'system'

function love.conf(t)
    t.console = false
    t.window.width = System.Screen.Width
    t.window.height = System.Screen.Height
end