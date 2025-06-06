
-- Card Class

CardClass = {}

CARD_STATE = {
  IDLE = 1,
  MOUSE_OVER = 2,
  GRABBED = 3
}

function CardClass:new(cardData, owner)
  local card = {}
  local metadata = {
    __index = CardClass,
    __tostring = function(a)
      return a.dataClass.title or "MISSING CARD NAME"
    end
    }
  setmetatable(card, metadata)
  
  card.position = Vector(10, 10)
  card.size = Vector(50, 70)
  card.dataClass = cardData
  card.cost = cardData.cost
  card.power = cardData.power
  card.owner = owner or nil
  card.currentLocation = nil
  card.isFaceUp = true
  card.state = CARD_STATE.IDLE
  
  return card
end

function CardClass:update()
  if self.isFaceUp then
    if self.state == CARD_STATE.GRABBED then
      local mousePos = Vector(
      love.mouse.getX(),
      love.mouse.getY()
    )
      self.position = mousePos - (self.size / 2)
    end
  end
end

function CardClass:draw()
  -- drop shadow
  if self.state ~= CARD_STATE.IDLE then
      love.graphics.setColor(0, 0, 0, 0.8) -- color values [0, 1]
      local offset = 4 * (self.state == CARD_STATE.GRABBED and 2 or 1)
      love.graphics.rectangle("fill", self.position.x + offset, self.position.y + offset, self.size.x, self.size.y, 6, 6)
    end
  
  if self.isFaceUp then
    -- fill white
    love.graphics.setColor(white)
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
    
    -- black outline
    love.graphics.setColor(black)
    love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
    
    -- First Letter of Name of Card
    love.graphics.print(string.sub(self.dataClass.title, 1, 3), self.position.x + 15, self.position.y + 25, 0, 1, 1)
    
    -- Power Number
    love.graphics.setColor(1, 0.2, 0.2, 1)
    love.graphics.circle("fill", self.position.x + (self.size.x / 2), self.position.y + 12, 10)
    love.graphics.setColor(white)
    if self.power < 10 then
      love.graphics.print(self.power, self.position.x + (self.size.x / 2) - 3, self.position.y + 5)
    else
      love.graphics.print(self.power, self.position.x + (self.size.x / 2) - 8, self.position.y + 5)
    end
    
    -- Cost Number
    love.graphics.setColor(0.2, 0.2, 1, 1)
    love.graphics.circle("fill", self.position.x + (self.size.x / 2), self.position.y + self.size.y - 12, 10)
    love.graphics.setColor(white)
    love.graphics.print(self.cost, self.position.x + (self.size.x / 2) - 3, self.position.y + self.size.y - 20)
  else
    --fill blue
    love.graphics.setColor(blue)
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
    -- black outline
    love.graphics.setColor(black)
    love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  end
end

function CardClass:checkForMouseOver()
  if self.isFaceUp and self.currentLocation == nil then
    local MouseOver = isMouseOver(self)
    if MouseOver and grabber.heldObject ~= nil and grabber.heldObject ~= self then
      return
    end
    
    -- if mouse is over, card is in mouse over state, else it's in the idle state
    self.state = MouseOver and CARD_STATE.MOUSE_OVER or CARD_STATE.IDLE
    
    self:checkForGrabbed()
  end
end

function CardClass:checkForGrabbed()
  if self.isFaceUp then
    if self.state == CARD_STATE.MOUSE_OVER and grabber.grabPos ~= nil then
      self.state = CARD_STATE.GRABBED
      grabber.heldObject = self
      grabber.grabPos = self.position + (grabber.heldObject.size / 2)
    end
  end
end

function CardClass:playCard(playLocation)
  -- remove self from hand
  if self.currentLocation == nil then
    local selfIndex = 0
    for index, card in ipairs(self.owner.hand.cards) do
      if card == self then selfIndex = index end
    end
    table.remove(self.owner.hand.cards, selfIndex)
  end
  
  -- put self in the locaiton
  table.insert(playLocation.cards[self.owner], self)
  self.currentLocation = playLocation
  print("played " .. tostring(self))
  print("location cards len")
  print(#self.currentLocation.cards)
  
  -- put refrence to self in eventQueue
  table.insert(Game.eventQueue[self.owner], self)
end

function CardClass:flip()
  self.isFaceUp = true
  
  self:onReveal()
end

function CardClass:changePower(value)
  self.power = self.power + value
end

function CardClass:setPower(value)
  self.power = value
end

function CardClass:getEnemyCardsHere()
  local cardList = {}
  for _, player in ipairs(Game.players) do
    if player ~= self.owner then
      for _, card in ipairs(self.currentLocation.cards[player]) do
        table.insert(cardList, card)
      end
    end
  end
  return cardList
end

function CardClass:getOwnCardsHere()
  local cardList = {}
  for _, player in ipairs(Game.players) do
    if player == self.owner then
      for _, card in ipairs(self.currentLocation.cards[player]) do
        table.insert(cardList, card)
      end
    end
  end
  return cardList
end

function CardClass:discard()
  if self.currentLocation ~= nil then
    for index, card in ipairs(self.currentLocation.cards[self.owner]) do
      if card == self then
        table.remove(self.currentLocation.cards[self.owner], index)
        self.currentLocation = nil
      end
    end
  end
  
  for index, card in ipairs(self.owner.hand.cards) do
    if card == self then
      table.remove(self.owner.hand.cards, index)
    end
  end
  
  for index, card in ipairs(Game.eventQueue[self.owner]) do
    if card == self then
      table.remove(Game.eventQueue[self.owner], index)
    end
  end
  
  table.insert(self.owner.discard.cards, self)
end

function CardClass:onReveal()
  if self.dataClass.onReveal then
    self.dataClass:onReveal(self)
    print(tostring(self) .. " did onReveal!")
  else
    print(tostring(self) .. " does not have an onReveal")
  end
end

function CardClass:onEndOfTurn()
  if self.dataClass.onEndOfTurn then
    self.dataClass:onEndOfTurn(self)
  else
    print(tostring(self) .. " does not have an onEndOfTurn")
  end
end