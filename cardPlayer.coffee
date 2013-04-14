_u = require('underscore')
types = require('./lib/hearts_types')
class CardPlayer
  constructor: (hand) ->
    @hand = hand

  chooseCard: (trickNumber, trick) ->
    if @twoClubs()?
      console.log "playing two of clubs"
      @twoClubs()
    else if trick.played[0]? and @matchingSuit(trick).length > 0
      # grabs the lowest matching suit
      console.log "playing matching suit"
      @matchingSuit(trick)[0]
    else
      # grabs the first card (off suit)
      console.log "playing off suit"
      @hand[0]

  matchingSuit: (trick) ->
    suited_cards = _u.filter @hand, (card) ->
      card.suit == trick.played[0].suit
    _u.sortBy(suited_cards, (card) -> card.rank)

  twoClubs: () ->
    _u.find(@hand, (card) -> card.suit == types.Suit.CLUBS && card.rank == types.Rank.TWO)

module.exports.CardPlayer = CardPlayer
