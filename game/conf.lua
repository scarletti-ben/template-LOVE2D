-- < ------------------------------------------------------
-- < Global Variables
-- < ------------------------------------------------------

W = 800
H = 600
CX = W / 2
CY = H / 2
PATHS = {
    image = "assets/player_80x80.png",
    music = "assets/loading.wav"
}

-- < ------------------------------------------------------
-- < Core Love Functions
-- < ------------------------------------------------------

--- Configure window properties
--- - Called once by Love at the beginning of the game
--- @param t table Configuration table provided by Love
function love.conf(t)
   t.window.title = "Game Title"
   t.window.width = W
   t.window.height = H
   t.window.resizable = false
   t.window.vsync = true
end