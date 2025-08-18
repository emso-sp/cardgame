require "setup"
require "graphical_elemets"

io.stdout:setvbuf("no")

function love.load()
    setup()
    showbutton = true;
    deck52 = createDeck()
    deckPlayer = {}
    deckCom = {}
    distributeCards(deck52)
    discardPlayer = {}
    discardCom = {}
end

function shuffle(deck)
    for i = #deck, 2, -1 do
        local j = math.random(1, i)
        deck[i], deck[j] = deck[j], deck[i]
    end
    return deck
end

function printDeck(deck)
    if #deck == 0 then
        print('deck is empty')
    end
    for i, v in ipairs(deck) do
        print('suit: '..v.suit..', rank: '..v.rank)
    end
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
    result = shuffle(result)
    
    return result
end

function distributeCards(deck52)
    -- distribute the deck of 52 cards and add 26 cards to deckPlayer and to deckCom
    table.move(deck52, 1, 26, 1, deckPlayer)
    table.move(deck52, 27, 52, 1, deckCom)
end

function playCard(deck)
    return table.remove(deck, 1)
end

function shuffleDiscardPile(discardPile, deck)
    print('reshuffle')
    deck = shuffle(discardPile)
    discardPile = {}
    return deck, discardPile
end

function duel(cardPlayer, cardCom)
    -- who won?
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

-- TODO: handle war

function love.draw()
    if startScreen then 
        createStartScreen()
    else 
        createIngameScreen()
        --[[if not next(deckPlayer) then
            deckPlayer = createDeck()
        end
        if not next(deckCom) then
            deckCom = createDeck()
        end]]
        -- TODO create card drawing and game mechanics
        -- TODO: check if deck is empty
        
        local cardPlayer = playCard(deckPlayer)
        local cardCom = playCard(deckCom)
        duel(cardPlayer, cardCom)

        if #deckPlayer == 0 then
            if #discardPlayer == 0 then
                print('Player lost the game')
                love.event.quit()
            end
            deckPlayer, discardPlayer = shuffleDiscardPile(discardPlayer, deckPlayer)
            print('player: ', #deckPlayer + #discardPlayer)
            print('com: ', #deckCom + #discardCom)
        end
        if #deckCom == 0 then
            if #discardCom == 0 then
                print('Player won the game')
                love.event.quit()
            end
            deckCom, discardCom = shuffleDiscardPile(discardCom, deckCom)
            print('player: ', #deckPlayer + #discardPlayer)
            print('com: ', #deckCom + #discardCom)
        end
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