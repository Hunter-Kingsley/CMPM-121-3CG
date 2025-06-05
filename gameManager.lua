
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
  
  game.eventQueue = {}
  for _, player in ipairs(game.players) do
    game.eventQueue[player] = {}
  end
  
  game.masterCardTable = {}
  
  newData = CardDataClass:new(2, 2, "Goku", "The legendary super saiyan", nil)
  newData2 = CardDataClass:new(2, 2, "Vegeta", "The legendary super saiyan", nil)
  newData3 = CardDataClass:new(2, 2, "Frieza", "Emperor of the Universe", nil)
  newData4 = CardDataClass:new(2, 2, "Cell", "The Ultimate Android", nil)
  newcard = newData:newCard(game.players[1])
  newcard2 = newData2:newCard(game.players[1])
  newcard3 = newData3:newCard(game.players[1])
  newcard4 = newData4:newCard(game.players[1])
  
  testCard = Titan:new(game.players[1])
  table.insert(game.players[1].hand.cards, testCard)
  table.insert(game.masterCardTable, testCard)
  
  table.insert(game.players[1].hand.cards, newcard)
  table.insert(game.masterCardTable, newcard)
  table.insert(game.players[1].hand.cards, newcard2)
  table.insert(game.masterCardTable, newcard2)
  table.insert(game.players[1].hand.cards, newcard3)
  table.insert(game.masterCardTable, newcard3)
  table.insert(game.players[1].hand.cards, newcard4)
  table.insert(game.masterCardTable, newcard4)
  
  return game
end

function GameManager:update()
  self:checkForMouseMoving()
  
  for _, player in ipairs(self.players) do
    player:update()
  end
  
  for _, location in ipairs(self.locations) do
    location:update()
  end
  
  for _, card in ipairs(self.masterCardTable) do
    card:update()
  end
end

function GameManager:draw()
  for _, player in ipairs(self.players) do
    player:draw()
  end
  
  for _, location in ipairs(self.locations) do
    location:draw()
  end
  
  for _, card in ipairs(self.masterCardTable) do
    card:draw()
  end
end

function GameManager:checkForMouseMoving()
  if grabber.currentMousePos == nil then
    return
  end
  
  for _, card in ipairs(self.masterCardTable) do
    card:checkForMouseOver(grabber)
  end
  
  for _, location in ipairs(self.locations) do
    location:checkForMouseOver()
  end
end

function GameManager:runTurn()
  for _, player in ipairs(self.players) do
    print(player)
    for _, card in ipairs(self.eventQueue[player]) do
      card:flip()
    end
  end
end