
-- Card Class

CardClass = {}

CARD_STATE = {
  IDLE = 1,
  MOUSE_OVER = 2,
  GRABBED = 3
}

function CardClass:new(cardData, owner)
  local card = {}
  local metadata = {__index = CardClass}
  setmetatable(card, metadata)
  
  card.position = Vector(10, 10)
  card.cost = cardData.cost or 0
  card.power = cardData.power or 0
  card.title = cardData.title or "No data class given for title"
  card.description = cardData.description or "No data class given for description"
  card.sprite = cardData.sprite or nil
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