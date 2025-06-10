
-- Hand Class

HandClass = {}

function HandClass:new(pX, pY)
  local hand = {}
  local metadata = {__index = HandClass}
  setmetatable(hand, metadata)
  
  hand.position = Vector(pX, pY)
  hand.size = Vector(580, 120)
  hand.cards = {}
  
  return hand
end

function HandClass:update()
  for index, card in ipairs(self.cards) do
    card.position.x = (self.position.x + 15) + ((index - 1) * 80)
    card.position.y = self.position.y + 10
  end
end

function HandClass:draw()
  love.graphics.setColor(black)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)
  
  love.graphics.setColor(0.4, 0.4, 0.4, 1)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end