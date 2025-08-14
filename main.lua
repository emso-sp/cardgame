require "setup"
require "graphical_elemets"
require "colors"


function love.load()
    setup()
    showbutton = true;
    deck1 = {}
    deck2 = {}
end

function createDeck()
    local result = {}
    if next(result) == nil then
        for suitIndex, suit in ipairs({'club', 'diamond', 'heart', 'spade'}) do
            for rank = 1, 13 do
                table.insert(result, {suit = suit, rank = rank})
                -- Temporary
                print('suit: '..suit..', rank: '..rank)
            end
        end
    end
    return result
end

function love.draw()
    if startScreen then 
        createStartScreen()
    else 
        createIngameScreen()
        if not next(deck1) then
            deck1 = createDeck()
        end
        if not next(deck2) then
            deck2 = createDeck()
        end
        -- TODO create card drawing and game mechanics
    end
end

function love.mousereleased(mx, my, button, istouch, presses)
    if button == 1 then -- left click
        if mx >= btn.x and mx <= btn.x + btn.w and my >= btn.y and my <= btn.y + btn.h then
            print("Button clicked!")
            love.audio.pause(music)
            showbutton = false;
            startScreen = false

            print('Total number of cards in deck: '..#deck1)
            print('Total number of cards in deck: '..#deck2)
        end
    end
end