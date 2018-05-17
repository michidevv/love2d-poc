-- local Tween = require 'src/Tween'

-- COLOR_MAX = 255
-- COLORS = {
--     grey = {68/COLOR_MAX, 97/COLOR_MAX, 118/COLOR_MAX,},
--     black = {0, 0, 0,},
-- }

-- function love.load()
--     SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()

--     messageBar = {opacity = 0.2, x = 50, y = -50}
--     opacityTween = Tween(0.5, messageBar, {opacity = 1, y = 50})
-- end

-- function love.update(dt)
--     opacityTween:update(dt)
-- end

-- function love.draw()
--     local r, g, b = unpack(COLORS.grey)
--     love.graphics.setColor(r, g, b, messageBar.opacity)
--     love.graphics.rectangle('fill', messageBar.x, messageBar.y,
--         SCREEN_WIDTH - messageBar.x * 2, 100, 8)

--     love.graphics.setColor(unpack(COLORS.black))
-- end


-- Full text we want to print
textToPrint  = "Hello! A typewriter is typing this. \nBye!"
printedText  = "" -- Section of the text printed so far

-- Timer to know when to print a new letter
typeTimerMax = 0.1
typeTimer 	 = 0.1

-- Current position in the text
typePosition = 0

function love.update(dt)
	-- Decrease timer
	typeTimer = typeTimer - dt

	-- Timer done, we need to print a new letter:
	-- Adjust position, use string.sub to get sub-string
	if typeTimer <= 0 then
		typeTimer = 0.1
		typePosition = typePosition + 1

		printedText = string.sub(textToPrint,0,typePosition)
	end

end

function love.draw(dt)
	-- Print text so far
	love.graphics.print(printedText,20,100)
end
