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

  get: (index) ->
    @hand[index]

  matchingSuit: (suit) ->
    suited_cards = _u.filter @hand, (card) ->
      card.suit == suit
    _u.sortBy(suited_cards, (card) -> card.rank)

  hearts: () ->
    @matchingSuit(types.Suit.HEARTS)

  spades: () ->
    @matchingSuit(types.Suit.SPADES)

  diamonds: () ->
    @matchingSuit(types.Suit.DIAMONDS)

  clubs: () ->
    @matchingSuit(types.Suit.CLUBS)

  twoClubs: () ->
    @hasCard(types.Rank.TWO, types.Suit.CLUBS)

  queenSpades: () ->
    @hasCard(types.Rank.QUEEN, types.Suit.SPADES)

  aceSpades: () ->
    @hasCard(types.Rank.ACE, types.Suit.SPADES)

  kingSpades: () ->
    @hasCard(types.Rank.KING, types.Suit.SPADES)


module.exports.Hand = Hand
