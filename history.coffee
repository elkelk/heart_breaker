_u = require('underscore')
types = require('./lib/hearts_types')

class History
  constructor: () ->
    @tricks = []
    @played_cards = []
    @user_played =
      north: []
      east:  []
      south: []
      west:  []
    @initialize_player_has_suit()

  initialize_player_has_suit: () ->
    @player_has_suit = {}
    _u.values(types.Position).map (position) =>
      @player_has_suit[position] = {}
      _u.values(types.Suit).map (suit) =>
        @player_has_suit[position][suit] = true

  record: (trick) ->
    @tricks.push(trick)
    @played_cards.push trick.played...
    @record_user_played(trick)

  record_user_played:(trick) ->
    leading_suit = trick.played[0].suit
    play_array = switch trick.leader
      when types.Position.NORTH then [1,2,3,4]
      when types.Position.EAST then [2,3,4,1]
      when types.Position.SOUTH then [3,4,1,2]
      when types.Position.WEST then [4,1,2,3]
    for card, index in trick.played
      player = play_array[index]
      if card.suit != leading_suit
        @player_has_suit[player][leading_suit] = false
      switch player
        when 1 then @user_played.north.push card
        when 2 then @user_played.east.push card
        when 3 then @user_played.south.push card
        when 4 then @user_played.west.push card

  has_suit: (player, suit) ->
    @player_has_suit[player][suit]

  cards_left_above: (card) ->
    cards = @cards_played_in_suit(card.suit).filter (suited_card) ->
      card.rank < suited_card.rank
    14 - card.rank - cards.length

  cards_left_below: (card) ->
    cards = @cards_played_in_suit(card.suit).filter (suited_card) ->
      card.rank > suited_card.rank
    card.rank - 2 - cards.length

  cards_played_in_suit: (suit) ->
    cards = @played_cards.filter (card) -> card.suit == suit
    cards.sort
    cards


module.exports.History = History
