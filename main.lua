--18 up, 25 across

--[[function CreateQuads(quadArray, tileSize, tileset, rows, cols, tileKey)
    local index, xPos, yPos = 1, 0, 0

    for _ = 1, rows do
        for __ = 1, cols do
            quadArray[tileKey[index] = love.graphics.newQuad(xPos, yPos, tileSize, tileSize, tileset:getWidth(), tileset:getHeight())
            xPos = xPos + tileSize
            index = index + 1
        end
        xPos = 0
        yPos = yPos + tileSize
    end
end]]

function love.load(args)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    tileset = love.graphics.newImage('countryside.png')
    x, y = nil, nil
    currentTile = 1
    drawTile = false
    TileMap = {}
    TileQuads = {}
    rows, cols = 2, 2
    tileKey = {' ', '#', '*', '^'}

    TileQuads[' '] = love.graphics.newQuad(0, 0, 32, 32, tileset:getWidth(), tileset:getHeight())
    TileQuads['#'] = love.graphics.newQuad(0, 32, 32, 32, tileset:getWidth(), tileset:getHeight())

    love.mouse.setVisible(false)
    --love.keyboard.setKeyRepeat(false)
    --CreateQuads(TileQuads, 32, tileset, rows, cols, tileKey)
    for i = 1,18 do
        TileMap[i] = {}
    end

    TileMap[18][25] = '#'
    TileMap[1][1] = ' '
end

function love.update(dt)
    x, y = love.mouse.getX(), love.mouse.getY()


    mouseX, mouseY = 0, 0

    if love.mouse.isDown(1) then
        mouseX, mouseY = love.mouse.getX() / 32, love.mouse.getY() / 32
    end
end

function love.keypressed(key, isrepeat)
      --if not isrepeat then
          if key == "right" then
              if currentTile < rows * cols then
                  currentTile = currentTile + 1
              else
                  currentTile = 1
              end
          elseif key == "left" then
              if currentTile > 1 then
                  currentTile = currentTile - 1
              else
                  currentTile = rows * cols
              end
          end
      --end
end

function love.draw()
        for yAxis = 1, 18 do
            for xAxis = 1, 25 do
                    if TileMap[yAxis][xAxis] ~= nil then
                        index = TileMap[yAxis][xAxis]
                        love.graphics.draw(tileset, TileQuads[index], (xAxis - 1) * 32, (yAxis - 1) * 32)
                    end
            end
        end

    love.graphics.draw(tileset, TileQuads[' '], x, y)
    love.graphics.print("X: " .. tostring(math.floor(mouseX)), 0, 0)
    love.graphics.print("Y: " .. tostring(math.floor(mouseY)), 0, 20)
    love.graphics.print("Current tile key: " .. tileKey[currentTile], 0, 30)
    love.graphics.print("Current tile index: " .. currentTile, 0, 40)
end
