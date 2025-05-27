
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
  
  newData = CardDataClass:new(2, 2, "Goku", "The legendary super saiyan", nil)
  newData2 = CardDataClass:new(2, 2, "Vegeta", "The legendary super saiyan", nil)
  newcard = newData:newCard(game.players[1])
  newcard2 = newData2:newCard(game.players[1])
  
  table.insert(game.players[1].hand.cards, newcard)
  table.insert(game.players[1].hand.cards, newcard2)
  
  print(#game.players[1].hand.cards)
  
  return game
end

function GameManager:update()
  for _, player in ipairs(self.players) do
    player:update()
  end
  
  for _, location in ipairs(self.locations) do
    location:update()
  end
end

function GameManager:draw()
  for _, player in ipairs(self.players) do
    player:draw()
  end
  
  for _, location in ipairs(self.locations) do
    location:draw()
  end
  
  newcard:draw()
end