
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
      return a.dataClass.title or "MISSING NAME"
    end
    }
  setmetatable(card, metadata)
  
  card.position = Vector(10, 10)
  card.size = Vector(50, 70)
  card.dataClass = cardData
  card.owner = owner
  card.currentLocation = nil
  card.isFaceUp = true
  
  return card
end

function CardClass:draw()
  if self.isFaceUp then
    -- fill white
    love.graphics.setColor(white)
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
    -- black outline
    love.graphics.setColor(black)
    love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  end
end