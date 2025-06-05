
StartButtonClass = {}

function StartButtonClass:new(xPos, yPos)
  local startButton = {}
  local metadata = {__index = StartButtonClass}
  setmetatable(startButton, metadata)
  
  startButton.position = Vector(xPos, yPos)
  startButton.size = Vector(200, 50)
  
  return startButton
end

function StartButtonClass:draw()
  love.graphics.setColor(0.2, 0.7, 0.2, 1)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.print("Start", self.position.x + self.size.x / 2 - 28, self.position.y + self.size.y / 2 - 10, 0, 1.5, 1.5)
end

function StartButtonClass:StartTurn()
  print("STARTING THE TURN NOW")
  Game:runTurn()
end