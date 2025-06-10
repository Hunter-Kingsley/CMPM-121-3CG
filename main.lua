
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
require "location"
require "cardData"
require "card"
require "deck"
require "discard"
require "player"
require "grabber"
require "gameManager"
require "startButton"

cardRefrences = {
  WoodenCow,
  Pegasus,
  Minotaur,
  Titan,
  Ares,
  Cyclops,
  Artemis,
  Hades,
  Dionysus,
  Hermes,
  ShipOfTheseus,
  Midas,
  Persephone,
  Pandora,
  Icarus,
  Nyx,
  Helios
}

isWinner = false
winner = false

function love.load()
  math.randomseed(os.time())
  love.window.setMode(1280, 700)
  love.window.setTitle("Rivals of Olympus")
  love.graphics.setBackgroundColor(0.6, 0.6, 0.6, 1)
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  grabber = GrabberClass:new()
  
  Game = GameManager:new()
  
  Game:load()
  
  StartButton = StartButtonClass:new(1040, 625)
  
end

function love.update()
  grabber:update()
  
  Game:update()
end

function love.draw()
  
  Game:draw()
  
  StartButton:draw()
  
  if isWinner then
    if winner then
      love.graphics.print("You Lose!", 450, 300, 0, 4, 4)
    else
      love.graphics.print("You Win!", 450, 300, 0, 4, 4)
    end
  end
end

function isMouseOver(obj)
  local mousePos = grabber.currentMousePos
  local isMouseOverCheck = 
  mousePos.x > obj.position.x and
  mousePos.x < obj.position.x + obj.size.x and
  mousePos.y > obj.position.y and
  mousePos.y < obj.position.y + obj.size.y
  return isMouseOverCheck
end

function love.mousereleased(mx, my, mStartButton)
  if mStartButton == 1 and isMouseOver(StartButton) and isWinner == false then
    StartButton:StartTurn()
  end
end