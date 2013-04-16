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
    if @hand.twoClubs()?
      console.log "playing two of clubs"
      @hand.twoClubs()

    else if trick.played[0]? and @hand.matchingSuit(trick).length > 0
      # grabs the lowest matching suit
      console.log "playing matching suit"
      @hand.matchingSuit(trick)[0]

    else
      # grabs the first card (off suit)
      console.log "playing off suit"
      @hand.get(0)

  record: (resultTrick) ->
    @history.record(resultTrick)

module.exports.CardPlayer = CardPlayer
