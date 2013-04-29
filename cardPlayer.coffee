_u = require('underscore')
types = require('./lib/hearts_types')
hand = require('./hand')
history = require('./history')

class CardPlayer
  constructor: (inbound_hand) ->
    @hand = new hand.Hand(inbound_hand)
    @history = new history.History()

  chooseCard: (trickNumber, trick) ->
    card = @cardSelector(trickNumber, trick)
    @hand.play(card)
    card

  cardSelector: (trickNumber, trick) ->
    # leading
    if not trick.played[0]?
      if @hand.twoClubs()?
        @hand.twoClubs()

      else if @hand.spades().length > 0 && @hand.spades()[0].rank < 12
        @hand.spades()[0]

    # following
    else
      if @hand.matchingSuit(trick.played[0].suit).length > 0
        @hand.matchingSuit(trick.played[0].suit)[0]


      else if @hand.queenSpades()? and trickNumber > 1
        @hand.queenSpades()

      else if @hand.kingSpades()?
        @hand.kingSpades()

      else if @hand.aceSpades()?
        @hand.aceSpades()

      else if @hand.hearts().length > 0 && trickNumber > 1
        @hand.hearts()[@hand.hearts().length - 1]

      else
        @hand.get(0)

  record: (resultTrick) ->
    @history.record(resultTrick)

module.exports.CardPlayer = CardPlayer
