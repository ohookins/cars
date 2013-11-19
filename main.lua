function love.load()
    car = love.graphics.newImage("car.png")
    car_width = 100
    car_height = 170
    car_angle = 0
    car_rotation = 0.05
    car_speed = 5
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
        return
    else
        car_x = new_x
        car_y = new_y
    end
end

-- this doesn't really work with non-square objects...
function collision(x, y)
    if x - car_width/2 < 0 or x + car_width/2 > screen_width then
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
        move(car_speed)
    elseif love.keyboard.isDown('down') then
        move(-car_speed)
    end
    love.graphics.draw(car, car_x, car_y, car_angle, 1, 1, car_width/2, car_height/2)
end
