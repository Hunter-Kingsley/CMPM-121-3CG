
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
  "Who knows, maybe it'll \nscare somebody",
  love.graphics.newImage("Images/wooden_horse.png")
)

function WoodenCow:new(owner)
  return WoodenCow:newCard(owner)
end

Pegasus = CardDataClass:new(
  3,
  5,
  "Pegasus",
  "They fly now!?",
  love.graphics.newImage("Images/Pegasus-Greek-PNG.png")
)

function Pegasus:new(owner)
  return Pegasus:newCard(owner)
end

Minotaur = CardDataClass:new(
  5,
  9,
  "Minotaur",
  "They're a mean lookin' fella",
  love.graphics.newImage("Images/minotaur.png")
)

function Minotaur:new(owner)
  return Minotaur:newCard(owner)
end

Titan = CardDataClass:new(
  7,
  14,
  "Titan",
  "Like from that one show",
  love.graphics.newImage("Images/titan.png")
)

function Titan:new(owner)
  return Titan:newCard(owner)
end

Ares = CardDataClass:new(
  5,
  6,
  "Ares",
  "When Revealed: Gain +2 power \nfor each enemy card here",
  love.graphics.newImage("Images/ares.png")
)

function Ares:new(owner)
  return Ares:newCard(owner)
end

function Ares:onReveal(card)
  local cardsHere = card:getEnemyCardsHere()
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
  "When Revealed: Discard your \nother cards here, gain +2 power \nfor each discarded",
  love.graphics.newImage("Images/cyclops.png")
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
    axedCard:queueDiscard()
  end
end

Artemis = CardDataClass:new(
  4,
  5,
  "Artemis",
  "When Revealed: Gain +5 power \nif there is exactly one \nenemy card here",
  love.graphics.newImage("Images/artemis.png")
)

function Artemis:new(owner)
  return Artemis:newCard(owner)
end

function Artemis:onReveal(card)
  local enemiesList = card:getEnemyCardsHere()
  
  if #enemiesList == 1 then
    card:changePower(5)
  end
end

Hades = CardDataClass:new(
  6,
  8,
  "Hades",
  "When Revealed: Gain +2 power \nfor each card in your discard pile",
  love.graphics.newImage("Images/hades.png")
)

function Hades:new(owner)
  return Hades:newCard(owner)
end

function Hades:onReveal(card)
  for _, otherCard in ipairs(card.owner.discard.cards) do
    card:changePower(2)
  end
end

Dionysus = CardDataClass:new(
  6,
  8,
  "Dionysus",
  "When Revealed: Gain +2 power \nfor each of your other cards here",
  love.graphics.newImage("Images/dionysus.png")
)

function Dionysus:new(owner)
  return Dionysus:newCard(owner)
end

function Dionysus:onReveal(card)
  local ownCardsHere = card:getOwnCardsHere()
  
  for _, otherCard in ipairs(ownCardsHere) do
    if otherCard ~= card then
      card:changePower(2)
    end
  end
end

Hermes = CardDataClass:new(
  6,
  8,
  "Hermes",
  "When Revealed: Moves to \nanother location.",
  love.graphics.newImage("Images/hermes.png")
)

function Hermes:new(owner)
  return Hermes:newCard(owner)
end

function Hermes:onReveal(card)
  card:moveLocations()
end

ShipOfTheseus = CardDataClass:new(
  6,
  8,
  "Ship Of Theseus",
  "When Revealed: Add a copy with \n+1 power to your hand",
  love.graphics.newImage("Images/ShipOfTheseus.png")
)

function ShipOfTheseus:new(owner)
  return ShipOfTheseus:newCard(owner)
end

function ShipOfTheseus:onReveal(card)
  if #card.owner.hand.cards >= 7 then
    return
  end
  
  local newCard = nil
  for _, cardRef in ipairs(cardRefrences) do
    if cardRef.title == "Ship Of Theseus" then
      newCard = cardRef:newCard(card.owner)
    end
  end
  
  newCard:setPower(card.power + 1)
  table.insert(card.owner.hand.cards, newCard)
  table.insert(Game.masterCardTable, newCard)
end

Midas = CardDataClass:new(
  6,
  8,
  "Midas",
  "When Revealed: Set ALL cards \nhere to 3 power",
  love.graphics.newImage("Images/midas.png")
)

function Midas:new(owner)
  return Midas:newCard(owner)
end

function Midas:onReveal(card)
  local enemyCards = card:getEnemyCardsHere()
  local myCards = card:getOwnCardsHere()
  
  for _, otherCard in ipairs(enemyCards) do
    otherCard:setPower(3)
  end
  for _, otherCard in ipairs(myCards) do
    otherCard:setPower(3)
  end
end

Persephone = CardDataClass:new(
  3,
  5,
  "Persephone",
  "When Revealed: Discard the \nlowest power card in your hand",
  love.graphics.newImage("Images/persephone.png")
)

function Persephone:new(owner)
  return Persephone:newCard(owner)
end

function Persephone:onReveal(card)
  if #card.owner.hand.cards < 1 then
    return
  end
  
  local chosenCard = card.owner.hand.cards[#card.owner.hand.cards]
  for _, otherCard in ipairs(card.owner.hand.cards) do
    if otherCard.power < chosenCard.power then
      chosenCard = otherCard
    end
  end
  
  chosenCard:queueDiscard()
end

Pandora = CardDataClass:new(
  8,
  15,
  "Pandora",
  "When Revealed: If no ally cards \nare here, lower this card's \npower by 5",
  love.graphics.newImage("Images/pandora.png")
)

function Pandora:new(owner)
  return Pandora:newCard(owner)
end

function Pandora:onReveal(card)
  if #card.currentLocation.cards[card.owner] == 1 and card.currentLocation.cards[card.owner][1] == card then
    card:changePower(-5)
  end
end

Icarus = CardDataClass:new(
  2,
  3,
  "Icarus",
  "End of Turn: Gains +1 power, but \nis discarded when its power \nis greater than 7",
  love.graphics.newImage("Images/icarus.png")
)

function Icarus:new(owner)
  return Icarus:newCard(owner)
end

function Icarus:onEndOfTurn(card)
  card:changePower(1)
  
  if card.power > 7 then
    card:queueDiscard()
  end
end

Nyx = CardDataClass:new(
  5,
  3,
  "Nyx",
  "When Revealed: Discards your \nother cards here, add their \npower to this card",
  love.graphics.newImage("Images/nyx.png")
)

function Nyx:new(owner)
  return Nyx:newCard(owner)
end

function Nyx:onReveal(card)
  local myCardsHere = card:getOwnCardsHere()
  
  for _, otherCard in ipairs(myCardsHere) do
    if otherCard ~= card then
      card:changePower(otherCard.power)
      otherCard:queueDiscard()
    end
  end
end

Helios = CardDataClass:new(
  6,
  12,
  "Helios",
  "When Revealed: Discards your \nother cards here, add their \npower to this card",
  love.graphics.newImage("Images/helios.png")
)

function Helios:new(owner)
  return Helios:newCard(owner)
end

function Helios:onEndOfTurn(card)
  card:queueDiscard()
end