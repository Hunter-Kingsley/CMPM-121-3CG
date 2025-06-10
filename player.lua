
-- Player Class

PlayerClass = {}

function PlayerClass:new(isBot)
  local player = {}
  local metadata = {__index = PlayerClass}
  setmetatable(player, metadata)
  
  player.isBot = isBot
  player.score = 0
  player.mana = 0
  
  -- Logic for choosing where the hand should be placed (player hand is on bottom while AI hand is at the top of the screen)
  local handPos = Vector(0, 0)
  if (player.isBot) then
    handPos = Vector(350, 3)
  else 
    handPos = Vector(350, 577)
  end
  player.hand = HandClass:new(handPos.x, handPos.y)
  
  player.deck = DeckClass:new(player)
  player.discard = DiscardClass:new(player)
  
  return player
end

function PlayerClass:load()
  self.deck:shuffle()
  self.deck:drawCards(3)
end

function PlayerClass:update()
  self.hand:update()
  self.deck:update()
  self.discard:update()
end

function PlayerClass:draw()
  self.hand:draw()
  self.discard:draw()
  
  local yOssfet = self.hand.size.y
  if not self.isBot then
    yOssfet = 0
  end
  
  -- mana number
  love.graphics.setColor(0.2, 0.2, 1, 1)
    love.graphics.circle("fill", self.hand.position.x, self.hand.position.y + yOssfet, 15)
    love.graphics.setColor(white)
    if self.mana < 10 then
      love.graphics.print(self.mana, self.hand.position.x - 5, self.hand.position.y - 10 + yOssfet, 0, 1.3, 1.3)
    else
      love.graphics.print(self.mana, self.hand.position.x - 10, self.hand.position.y - 10 + yOssfet, 0, 1.3, 1.3)
    end
    
  -- score number
  love.graphics.setColor(0, 0.7, 0, 1)
    love.graphics.circle("fill", self.hand.position.x + self.hand.size.x, self.hand.position.y + yOssfet, 15)
    love.graphics.setColor(white)
    if self.score < 10 then
      love.graphics.print(self.score, self.hand.position.x + self.hand.size.x - 5, self.hand.position.y - 10 + yOssfet, 0, 1.3, 1.3)
    else
      love.graphics.print(self.score, self.hand.position.x + self.hand.size.x - 10, self.hand.position.y - 10 + yOssfet, 0, 1.3, 1.3)
    end
end

function PlayerClass:botPlay()
  table.sort(self.hand.cards, function(a, b) return a.cost > b.cost end)
  
  while #self.hand.cards > 0 and self.mana >= self.hand.cards[#self.hand.cards].cost do
    if #Game.locations[1].cards[self] >= 4 and #Game.locations[2].cards[self] >= 4 and #Game.locations[3].cards[self] >= 4 then
      break
    end
    
    local validLocation = nil
    while validLocation == nil or #validLocation.cards[self] >= 4 do
      if #Game.locations[1].cards[self] >= 4 and #Game.locations[2].cards[self] >= 4 and #Game.locations[3].cards[self] >= 4 then
        break
      end
      print("looping")
      validLocation = Game.locations[math.random(#Game.locations)]
    end
    self.hand.cards[#self.hand.cards].isFaceUp = true
    self.hand.cards[#self.hand.cards]:playCard(validLocation)
  end
end