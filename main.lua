require "setup"
require "graphical_elemets"
require "colors"


function love.load()
    setup()
    showbutton = true;
end

function love.draw()
    if startScreen then 
        createStartScreen()
    else 
        createIngameScreen()
    end
end

function love.mousereleased(mx, my, button, istouch, presses)
    if button == 1 then -- left click
        if mx >= btn.x and mx <= btn.x + btn.w and my >= btn.y and my <= btn.y + btn.h then
            print("Button clicked!")
            love.audio.pause(music)
            showbutton = false;
            startScreen = false
        end
    end
end