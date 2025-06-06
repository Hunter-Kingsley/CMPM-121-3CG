
DiscardClass = {}

function DiscardClass:new(owner)
  local discard = {}
  local metadata = {__index = DiscardClass}
  setmetatable(discard, metadata)
  
  discard.position = Vector(owner.hand.position.x - 65, owner.hand.position.y + 10)
  discard.size = Vector(50, 70)
  discard.cards = {}
  discard.owner = owner
  
  return discard
end

function DiscardClass:update()
  for index, card in ipairs(self.cards) do
    card.position.x = self.position.x
    card.position.y = self.position.y
    card.isFaceUp = false
  end
end

function DiscardClass:draw()
  love.graphics.setColor(black)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)
end