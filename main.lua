
-- 3CG Game by Hunter Kingsley

io.stdout:setvbuf("no")

debug = true

red = {1, 0, 0, 1}
lightRed = {1, 0.5, 0.5, 1}
blue = {0, 0, 1, 1}
lightBlue = {0.5, 0.5, 1, 1}
green = {0, 1, 0, 1}
lightGreen = {0.5, 1, 0.5, 1}
black = {0, 0, 0, 1}
white = {1, 1, 1, 1}

require "vector"
require "hand"
require "player"
require "location"
require "card"
require "cardData"
require "grabber"
require "gameManager"

function love.load()
  love.window.setMode(1280, 700)
  love.window.setTitle("Greek Style 3CG")
  love.graphics.setBackgroundColor(0.6, 0.6, 0.6, 1)
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  grabber = GrabberClass:new()
  
  Game = GameManager:new()
  
end

function love.update()
  grabber:update()
  
  Game:update()
end

function love.draw()
  
  Game:draw()
end