btn = { x = 300, y = 250, w = 200, h = 50, text = "Start Battle!" }

function createStartScreen()
    if showbutton then
		love.graphics.setColor(love.math.colorFromBytes(0, 66, 8))
        love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h)

        love.graphics.setColor(1, 1, 1) 
        love.graphics.printf(btn.text, btn.x, btn.y + 15, 200, "center")
    end
end

function createIngameScreen()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(66, 22, 0))

end