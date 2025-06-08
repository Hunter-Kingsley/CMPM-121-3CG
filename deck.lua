
DeckClass = {}

function DeckClass:new(owner)
  local deck = {}
  local metatable = {__index = DeckClass}
  setmetatable(deck, metatable)
  
  deck.position = Vector(-500, -500)
  deck.cards = {}
  deck.owner = owner
  
  for index, card in ipairs(cardRefrences) do
    for i = 1, 2, 1 do
      local testCard = cardRefrences[index]:new(owner)
      table.insert(deck.cards, testCard)
    end
  end
  
  return deck
end

function DeckClass:update()
  for index, card in ipairs(self.cards) do
    card.position.x = self.position.x
    card.position.y = self.position.y
  end
end

function DeckClass:drawCards(cardsToDraw)
  if #self.cards < 1 or #self.owner.hand.cards >= 7 then
    return
  end
  
  for i = 1, cardsToDraw, 1 do
    local card = table.remove(self.cards, #self.cards)
    table.insert(self.owner.hand.cards, card)
    table.insert(Game.masterCardTable, card)
  end
end

function DeckClass:shuffle()
  local cardCount = #self.cards
  for i = 1, cardCount do
    local randIndex = math.random(cardCount)
    local temp = self.cards[randIndex]
    self.cards[randIndex] = self.cards[cardCount]
    self.cards[cardCount] = temp
    cardCount = cardCount - 1
  end
  return deck
end