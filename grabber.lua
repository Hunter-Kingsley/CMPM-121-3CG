
-- Grabber Class

GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.grabPos = nil
  grabber.heldObject = nil
  grabber.lastSeenCard = nil
  
  return grabber
end

function GrabberClass:update()
  self.currentMousePos = Vector(
    love.mouse.getX(),
    love.mouse.getY()
  )
  
  if love.mouse.isDown(1) and self.grabPos == nil and self.heldObject == nil then
    self:grab()
  end

  if not love.mouse.isDown(1) and self.grabPos ~= nil then
    self:release()
  end  
end

function GrabberClass:grab()
  
end

function GrabberClass:release()
  
end