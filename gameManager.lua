
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
  
  self:iterateTurnUpkeep()
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
  local cardsToRemove = {}
  local leaderboard = {self.players[1], self.players[2]}
  
  table.sort(leaderboard, function(a, b) return a.score > b.score end)
  
  
  for _, player in ipairs(leaderboard) do
    print("player:")
    print(player)
    
    for _, card in ipairs(self.eventQueue[player]) do
      card:flip()
      if not card.dataClass.onEndOfTurn then
        table.insert(cardsToRemove, card)
      end
    end
  end
  
  self:iterateTurnUpkeep()
  
  for _, player in ipairs(leaderboard) do
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
    
    if player.isBot then
      player:botPlay()
    end
  end
end

function GameManager:iterateTurnUpkeep()
  self.turn = self.turn + 1
  
  
  for _, player in ipairs(self.players) do
    player.deck:drawCards(1)
    player.mana = self.turn
  end
  
  for _, Location in ipairs(self.locations) do
    self:addScoreToWinners(Location)
  end
  
  for _, player in ipairs(self.players) do
    if player.score >= 25 then
      isWinner = true
      winner = player.isBot
    end
  end
end

function GameManager:addScoreToWinners(Location)
  local scores = {}
  for _, player in ipairs(self.players) do
    local tempTotal = 0
    for _, card in ipairs(Location.cards[player]) do
      tempTotal = tempTotal + card.power
    end
    table.insert(scores, tempTotal)
  end
  
  if scores[1] > scores[2] then
    self.players[1].score = self.players[1].score + math.abs(scores[1] - scores[2])
  else
    self.players[2].score = self.players[2].score + math.abs(scores[1] - scores[2])
  end
end