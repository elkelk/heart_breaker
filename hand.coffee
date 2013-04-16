_u = require('underscore')
types = require('./lib/hearts_types')

class Hand
  constructor: (@hand) ->
    @played = []

  play: (card) ->
    @hand.splice(@hand.indexOf(card), 1)
    @played.push(card)

  hasCard: (rank, suit) ->
    _u.find(@hand, (card) -> card.suit == suit && card.rank == rank)

  twoClubs: () ->
    @hasCard(types.Rank.TWO, types.Suit.CLUBS)

  queenSpades: () ->
    @hasCard(types.Rank.QUEEN, types.Suit.SPADES)

  get: (index) ->
    @hand[index]

  matchingSuit: (trick) ->
    suited_cards = _u.filter @hand, (card) ->
      card.suit == trick.played[0].suit
    _u.sortBy(suited_cards, (card) -> card.rank)


module.exports.Hand = Hand
