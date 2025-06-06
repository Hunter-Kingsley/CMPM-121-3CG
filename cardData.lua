
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

Ares = CardDataClass:new(
  5,
  6,
  "Ares",
  "When Revealed: Gain +2 power for each enemy card here.",
  nil
)

function Ares:new(owner)
  return Ares:newCard(owner)
end

function Ares:onReveal(card)
  local cardsHere = card:getEnemyCardsHere()
  print(#cardsHere)
  for i, otherCard in ipairs(cardsHere) do
    if otherCard.owner ~= card.owner then
      card:changePower(2)
    end
  end
end

Cyclops = CardDataClass:new(
  3,
  4,
  "Cyclops",
  "When Revealed: Discard your other cards here, gain +2 power for each discarded.",
  nil
)

function Cyclops:new(owner)
  return Cyclops:newCard(owner)
end

function Cyclops:onReveal(card)
  local cardsToDiscard = {}
  for index, otherCard in ipairs(card.currentLocation.cards[card.owner]) do
    if card ~= otherCard then
      card:changePower(2)
      table.insert(cardsToDiscard, otherCard)
    end
  end
  
  for _, axedCard in ipairs(cardsToDiscard) do
    axedCard:discard()
  end
end