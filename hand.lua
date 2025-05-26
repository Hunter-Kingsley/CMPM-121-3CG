
-- Hand Class

HandClass = {}

function HandClass:new(pX, pY)
  local hand = {}
  local metadata = {__index = HandClass}
  setmetatable(hand, metadata)
  
  hand.position = Vector(pX, pY)
  hand.size = Vector(400, 90)
  
  return hand
end

function HandClass:draw()
  love.graphics.setColor(black)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)
  
  love.graphics.setColor(0.4, 0.4, 0.4, 1)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end