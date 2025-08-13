function love.load()
    local r, g, b = love.math.colorFromBytes(57, 133, 57)
    love.graphics.setBackgroundColor(r, g, b)


    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)

    showbutton = true;
    music = love.audio.newSource("battle.mp3", "stream")
end


-- Button position and size
local btn = { x = 300, y = 250, w = 200, h = 50, text = "Start Battle!" }


function love.draw()
    -- Draw button rectangle
    
    if showbutton then
        love.graphics.setColor(love.math.colorFromBytes(0, 66, 8)) -- RGB in 0-1 range
        love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h)

        love.graphics.setColor(1, 1, 1) 
        love.graphics.print(btn.text, btn.x, btn.y)
    end
end

function love.mousepressed(mx, my, button, istouch, presses)
    if button == 1 then -- left click
        if mx >= btn.x and mx <= btn.x + btn.w and my >= btn.y and my <= btn.y + btn.h then
            print("Button clicked!")
            love.audio.play(music)
            love.graphics.setBackgroundColor(love.math.colorFromBytes(66, 22, 0))
            showbutton = false;
        end
    end
end