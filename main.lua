function love.load()
    car = love.graphics.newImage("car.png")
    engine = love.audio.newSource("engine.ogg", "static")
    engine:setLooping(true)
    engine:setVolume(0.3)
    love.audio.play(engine)
    car_width = 100
    car_height = 170
    car_angle = 0
    car_rotation = 0.05
    car_accel = 0.15
    car_speed = 0
    car_x = 300
    car_y = 300

    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
end

--[[
function love.keypressed(key, unicode)
    if key == 'left' then
        car_angle = car_angle - car_rotation
    elseif key == 'right' then
        car_angle = car_angle + car_rotation
    end
end
]]--

function move(speed)
    new_x = car_x + math.sin(car_angle) * speed
    new_y = car_y - math.cos(car_angle) * speed

    if collision(new_x, new_y) then
        -- gradually reduce speed
        car_speed = car_speed * 0.5
    else
        car_x = new_x
        car_y = new_y
    end
end

-- pretend it is square (only the front and back really matters anyway)
function collision(x, y)
    if x - car_height/2 < 0 or x + car_height/2 > screen_width then
        return true
    end

    if y - car_height/2 < 0 or y + car_height/2 > screen_height then
        return true
    end

    return false
end

function love.draw()
    -- Steering
    if love.keyboard.isDown('left') then
        car_angle = car_angle - car_rotation
    elseif love.keyboard.isDown('right') then
        car_angle = car_angle + car_rotation
    end

    -- Speed
    if love.keyboard.isDown('up') then
        car_speed = car_speed + car_accel
        move(car_speed)
    elseif love.keyboard.isDown('down') then
        car_speed = car_speed - car_accel
        move(car_speed)
    else
        car_speed = car_speed * 0.95
        move(car_speed)
    end

    -- Engine noise
    if car_speed ~= 0 then
        engine:setPitch(1 + math.abs(car_speed) * 0.1)
        engine:setVolume(0.4)
    else
        engine:setPitch(1)
        engine:setVolume(0.3)
    end

    -- Draw the car
    love.graphics.draw(car, car_x, car_y, car_angle, 1, 1, car_width/2, car_height/2)
end
