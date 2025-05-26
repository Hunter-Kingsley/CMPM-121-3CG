
-- Game Manager Class

GameManager = {}

function GameManager:new()
  local game = {}
  local metadata = {__index = GameManager}
  setmetatable(game, metadata)
  
  game.turn = 0
  game.players = {
    PlayerClass:new(false),
    PlayerClass:new(true)
  }
  game.locations = {
    LocationClass:new(490, 150, lightGreen, game.players),
    LocationClass:new(180, 150, lightRed, game.players),
    LocationClass:new(800, 150, lightBlue, game.players)
  }
  
  return game
end

function GameManager:update()
  for _, player in ipairs(self.players) do
    player:update()
  end
  
  for _, player in ipairs(self.locations) do
    player:update()
  end
end

function GameManager:draw()
  for _, player in ipairs(self.players) do
    player:draw()
  end
  
  for _, player in ipairs(self.locations) do
    player:draw()
  end
end