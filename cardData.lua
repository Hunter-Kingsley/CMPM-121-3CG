
-- Card Data Class

CardDataClass = {}

function CardDataClass:new(c, p, t, d, s)
  local cardData = {}
  local metadata = {__index = CardDataClass}
  setmetatable(cardData, metadata)
  
  cardData.cost = c or 0
  cardData.power = p or 0
  cardData.title = t or "No data class given for title"
  cardData.description = d or "No data class given for description"
  cardData.sprite = s or nil
  
  return cardData
end

function CardDataClass:newCard(owner)
  return CardClass:new(self, owner)
end

-- Card Data Prototype Definitions

WoodenCow = CardDataClass:new(
  1,
  1,
  "Wooden Cow",
  "Who knows, maybe it'll scare somebody",
  nil
)

function WoodenCow:new(owner)
  return WoodenCow:newCard(owner)
end

function WoodenCow:onReveal()
  print("MOOOOOOOOOOOOOOO")
end