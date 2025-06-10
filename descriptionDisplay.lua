
DescriptionDisplay = {}

function DescriptionDisplay:new()
  DescriptionDisplay.position = Vector(5, 510)
  DescriptionDisplay.size = Vector(325, 180)
  
  DescriptionDisplay.dataClass = nil
  
  return DescriptionDisplay
end

function DescriptionDisplay:draw()
  if self.dataClass == nil then return end
  
  love.graphics.setColor(0.2, 0.2, 0.2, 1)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
  love.graphics.setColor(black)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)
  
  love.graphics.setColor(white)
  love.graphics.print(self.dataClass.title, self.position.x + 10, self.position.y + 10, 0, 3, 3)
  love.graphics.print(self.dataClass.description, self.position.x + 10, self.position.y + 70, 0, 1.5, 1.5)
end

function DescriptionDisplay:onNotify(dataClass)
  self.dataClass = dataClass
end