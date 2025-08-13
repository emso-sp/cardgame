function setup()
    music = love.audio.newSource("battle2.mp3", "stream")
    love.audio.setVolume(0.5)
    love.audio.play(music)
    love.graphics.setBackgroundColor(love.math.colorFromBytes(57, 133, 57))

    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)
    startScreen = true
end