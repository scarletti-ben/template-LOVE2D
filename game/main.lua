-- < ------------------------------------------------------
-- < Local Variables
-- < ------------------------------------------------------

local image
local music
local x
local y
local speed = 400

-- < ------------------------------------------------------
-- < Core Love Functions
-- < ------------------------------------------------------

--- Initialise game resources and starting state
--- - Called once by Love at the beginning of the game
function love.load()
   image = love.graphics.newImage(PATHS.image)
   music = love.audio.newSource(PATHS.music, "stream")
   x = CX - image:getWidth() / 2
   y = CY - image:getHeight() / 2
   music:setLooping(true)
   music:play()
end

--- Update game logic
--- - Called each frame
--- - Handles image movement using arrow keys
--- @param dt number Time elapsed since last frame in seconds
function love.update(dt)
   if love.keyboard.isDown("up") then y = y - speed * dt end
   if love.keyboard.isDown("down") then y = y + speed * dt end
   if love.keyboard.isDown("left") then x = x - speed * dt end
   if love.keyboard.isDown("right") then x = x + speed * dt end
end

--- Update display
--- - Called each frame
--- - Render all visual elements to the display
function love.draw()
   love.graphics.draw(image, x, y)
   love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end
