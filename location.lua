
-- Location Class

LocationClass = {}

function LocationClass:new(xP, yP, color, playerTable)
  local location = {}
  local metadata = {__index = LocationClass}
  setmetatable(location, metadata)
  
  location.position = Vector(xP, yP)
  location.size = Vector(300, 400)
  location.color = color
  location.cards = {}
  for _, player in ipairs(playerTable) do
    location.cards[player] = {}
  end
  
  return location
end

function LocationClass:update()
  
end

function LocationClass:draw()
  love.graphics.setColor(black)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)
  
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end