
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

Pegasus = CardDataClass:new(
  3,
  5,
  "Pegasus",
  "They fly now!?",
  nil
)

function Pegasus:new(owner)
  return Pegasus:newCard(owner)
end

Minotaur = CardDataClass:new(
  5,
  9,
  "Minotaur",
  "They're a mean lookin' fella",
  nil
)

function Minotaur:new(owner)
  return Minotaur:newCard(owner)
end

Titan = CardDataClass:new(
  7,
  14,
  "Titan",
  "Like from than one show ",
  nil
)

function Titan:new(owner)
  return Titan:newCard(owner)
end