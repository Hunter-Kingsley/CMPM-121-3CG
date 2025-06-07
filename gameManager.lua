
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
  game.cardsToDiscard = {}
  
--  testCard = cardRefrences[math.random(1, #cardRefrences)]:new(game.players[1])
--  table.insert(game.players[1].hand.cards, testCard)
--  table.insert(game.masterCardTable, testCard)
  
  return game
end

function GameManager:load()
  for _, player in ipairs(self.players) do
    player:load()
  end
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
    print("player:")
    print(player)
    local cardsToRemove = {}
    
    for _, card in ipairs(self.eventQueue[player]) do
      card:flip()
      if not card.dataClass.onEndOfTurn then
        table.insert(cardsToRemove, card)
      end
    end
    
    for _, card in ipairs(self.eventQueue[player]) do
      card:onEndOfTurn()
    end
    
    for _, card in ipairs(cardsToRemove) do
      for index, cardRef in ipairs(self.eventQueue[player]) do
        if card == cardRef then
          table.remove(self.eventQueue[player], index)
        end
      end
    end
    
    for _, card in ipairs(self.cardsToDiscard) do
      card:discard()
    end
    self.cardsToDiscard = {}
  end
  
  
end