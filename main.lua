require "setup"
require "graphical_elemets"

io.stdout:setvbuf("no")

function love.load()
    setup()
    showbutton = true;
    deckPlayer = {}
    deckCom = {}
    discardPlayer = {}
    discardCom = {}
end

function createDeck()
    local result = {}
    if next(result) == nil then
        for suitIndex, suit in ipairs({'club', 'diamond', 'heart', 'spade'}) do
            for rank = 1, 13 do
                table.insert(result, {suit = suit, rank = rank})
            end
        end
    end
    -- shuffle deck
    for i = #result, 2, -1 do
        local j = math.random(1, i)
        result[i], result[j] = result[j], result[i]
    end
    for i, v in ipairs(result) do
        print('suit: '..v.suit..', rank: '..v.rank)
    end
    return result
end

function playCard(deck)
    return table.remove(deck, 1)
end

function duel(cardPlayer, cardCom)
    -- who won?
    print('duel')
    if cardPlayer.rank > cardCom.rank then
        table.insert(discardPlayer, cardPlayer)
        table.insert(discardPlayer, cardCom)
    elseif cardPlayer.rank < cardCom.rank then
        table.insert(discardCom, cardPlayer)
        table.insert(discardCom, cardCom)
    else
        table.insert(discardPlayer, cardPlayer)
        table.insert(discardCom, cardCom)
    end
end

-- TODO: evaluate duell / battle

-- TODO: handle war

function love.draw()
    if startScreen then 
        createStartScreen()
    else 
        createIngameScreen()
        if not next(deckPlayer) then
            deckPlayer = createDeck()
        end
        if not next(deckCom) then
            deckCom = createDeck()
        end
        -- TODO create card drawing and game mechanics
        -- TODO: check if deck is empty
        local cardPlayer = playCard(deckPlayer)
        local cardCom = playCard(deckCom)
        duel(cardPlayer, cardCom)

    end
end

function love.mousereleased(mx, my, button, istouch, presses)
    if button == 1 then -- left click
        if mx >= btn.x and mx <= btn.x + btn.w and my >= btn.y and my <= btn.y + btn.h then
            print("Button clicked!")
            love.audio.pause(music)
            showbutton = false;
            startScreen = false

            print('Total number of cards in deck: '..#deckPlayer)
            print('Total number of cards in deck: '..#deckCom)
        end
    end
end