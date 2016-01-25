--18 up, 25 across
function CreateQuads(quadArray, tileSize, tileset, rows, cols, tileKey)
    local index, xPos, yPos = 1, 0, 0

    for _ = 1, rows do
        for __ = 1, cols do
            quadArray[tileKey[index]] = love.graphics.newQuad(xPos, yPos, tileSize, tileSize, tileset:getWidth(), tileset:getHeight())
            xPos = xPos + tileSize
            index = index + 1
        end
        xPos = 0
        yPos = yPos + tileSize
    end
end

function AddTile(tilemap, mouseX, mouseY, tilekey)
    yTile, xTile = math.floor(love.mouse.getY() / 32)  + 1, math.floor(love.mouse.getX() / 32) + 1
    tilemap[yTile][xTile] = tilekey
end

function RemoveTile(tilemap, mouseX, mouseY)
    yTile, xTile = math.floor(love.mouse.getY() / 32)  + 1, math.floor(love.mouse.getX() / 32) + 1
    tilemap[yTile][xTile] = nil
end

function love.load(args)
    love.mouse.setVisible(false)

    --Zerobrane debugging
    --if arg[#arg] == "-debug" then require("mobdebug").start() end

    -- Loads the tileset
    tileset = love.graphics.newImage('countryside.png')
    x, y, tileSize = nil, nil, 32

    -- Index of the current tile to be drawn, corresponds with tile key
    currentTile = 1

    -- Table to hold string representation of tiles
    TileMap = {}

    rows, cols = 2, 2

    -- Table with tile keys to allow increment if tiles
    tileKey = {' ', '#', '*', '^'}

    -- Table of tile quads
    TileQuads = {}
    CreateQuads(TileQuads, tileSize, tileset, rows, cols, tileKey)

    -- Iterate through array, create another table for each y, for a 2D array
    for i = 1,18 do
        TileMap[i] = {}
    end
end

function love.update(dt)
    if love.mouse.getX() <= 0 then
        xPos = 0
    elseif love.mouse.getX() >= love.graphics.getWidth() - tileSize then
        xPos = love.graphics.getWidth() - 32
    elseif love.mouse.getY() <= 0 then
        yPos = 0
    elseif love.mouse.getY() >= love.graphics.getHeight() - tileSize then
        yPos = love.graphics.getHeight() - tileSize
    else
        xPos, yPos = love.mouse.getX(), love.mouse.getY()
    end

end

function love.keypressed(key, isrepeat)
    -- Change tiles, wraps around if end is reached.
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
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then -- the primary button
      AddTile(TileMap, x, y, tileKey[currentTile])
  elseif button == 2 then
      RemoveTile(TileMap, x, y)
  end
end

function love.draw()
    -- Draws tile map, black if nil
    for yAxis = 1, 18 do
        for xAxis = 1, 25 do
            if TileMap[yAxis][xAxis] ~= nil then
                index = TileMap[yAxis][xAxis]
                love.graphics.draw(tileset, TileQuads[index], (xAxis - 1) * 32, (yAxis - 1) * 32)
            end
        end
    end

    love.graphics.draw(tileset, TileQuads[tileKey[currentTile]], xPos, yPos)
end
