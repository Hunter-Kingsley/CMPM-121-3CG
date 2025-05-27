
-- Player Class

PlayerClass = {}

function PlayerClass:new(isBot)
  local player = {}
  local metadata = {__index = PlayerClass}
  setmetatable(player, metadata)
  
  player.isBot = isBot
  player.score = 0
  player.mana = 0
  
  -- Logic for choosing where the hand should be placed (player hand is on bottom while AI hand is at the top of the screen)
  local handPos = Vector(0, 0)
  if (player.isBot) then
    handPos = Vector(440, 3)
  else 
    handPos = Vector(440, 607)
  end
  player.hand = HandClass:new(handPos.x, handPos.y)
  
  return player
end

function PlayerClass:update()
  self.hand:update()
end

function PlayerClass:draw()
  self.hand:draw()
end