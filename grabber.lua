
-- Grabber Class

GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.grabPos = nil
  grabber.heldObject = nil
  grabber.lastSeenCard = nil
  grabber.currentMousePos = nil
  grabber.lastSeenLocation = nil
  
  grabber.observers = {}
  grabber:addObserver(descriptionDisplay)
  
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
  
  if self.lastSeenCard ~= nil then
    if isMouseOver(self.lastSeenCard) then
      self:notifyObservers(self.lastSeenCard)
    else
      self:notifyObservers(nil)
    end
  end
end

function GrabberClass:grab()
  self.grabPos = self.currentMousePos
end

function GrabberClass:release()
  if self.lastSeenLocation ~= nil and self.heldObject ~= nil then
    local isOverLocation = isMouseOver(self.lastSeenLocation)
    if isOverLocation then
      if self.heldObject.owner.mana >= self.heldObject.cost and #self.lastSeenLocation.cards[self.heldObject.owner] < 4 then
        self.heldObject:playCard(self.lastSeenLocation)
      end
    end
    
    self.heldObject.state = CARD_STATE.IDLE
    self.heldObject = nil
  end
  self.grabPos = nil
end

-- These functions are from Zac Emerzain's Day 21 Demo
function GrabberClass:addObserver(newObserver)
  -- Redudancy Check
  local alreadyAdded = false
  for _, observer in ipairs(self.observers) do
    if observer == newObserver then
      alreadyAdded = true
      break
    end
  end
  if alreadyAdded then
    return
  end
  
  table.insert(self.observers, newObserver)
end

function GrabberClass:notifyObservers(card)
  for i, observer in ipairs(self.observers) do
    if observer.onNotify ~= nil then
      if card == nil then
        observer:onNotify(nil)
      else
        observer:onNotify(card.dataClass or nil)
      end
    end
  end
end