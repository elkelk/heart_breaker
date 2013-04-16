history_module = require('../history')
types = require "../lib/hearts_types"
should = require("should")

describe "History", ->
  beforeEach ->
    @tenDiamonds = { suit: types.Suit.DIAMONDS, rank: types.Rank.TEN }
    @trick1 =
      leader: 2
      played: [
        { suit: types.Suit.DIAMONDS, rank: types.Rank.SIX },
        { suit: types.Suit.DIAMONDS, rank: types.Rank.JACK },
        { suit: types.Suit.DIAMONDS, rank: types.Rank.TWO },
        { suit: types.Suit.DIAMONDS, rank: types.Rank.ACE }
      ]
    @trick2 =
      leader: 1
      played: [
        { suit: types.Suit.SPADES, rank: types.Rank.SIX },
        { suit: types.Suit.SPADES, rank: types.Rank.JACK },
        { suit: types.Suit.SPADES, rank: types.Rank.TWO },
        { suit: types.Suit.SPADES, rank: types.Rank.ACE }
      ]
    @trick3 =
      leader: 4
      played: [
        { suit: types.Suit.SPADES, rank: types.Rank.SIX },
        { suit: types.Suit.SPADES, rank: types.Rank.JACK },
        { suit: types.Suit.SPADES, rank: types.Rank.QUEEN },
        { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
      ]

  describe "#record", ->
    it "should add the trick to the end of the played tricks", ->
      history = new history_module.History()
      history.record(@trick1)
      history.record(@trick2)
      history.tricks.should.eql([@trick1, @trick2])

    it "should add the cards to the played cards", ->
      expected = [
          { suit: 22, rank: 6 },
          { suit: 22, rank: 11 },
          { suit: 22, rank: 2 },
          { suit: 22, rank: 14 },
          { suit: 23, rank: 6 },
          { suit: 23, rank: 11 },
          { suit: 23, rank: 2 },
          { suit: 23, rank: 14 }
      ]

      history = new history_module.History()
      history.record(@trick1)
      history.record(@trick2)
      history.played_cards.should.eql(expected)

    it "should add the cards to the cards played by user", ->
      expected_north = [
        { suit: 22, rank: 14 },
        { suit: 23, rank: 6 }
      ]
      expected_east =  [
        { suit: 22, rank: 6 },
        { suit: 23, rank: 11 }
      ]
      expected_south = [
        { suit: 22, rank: 11 },
        { suit: 23, rank: 2 }
      ]
      expected_west =  [
        { suit: 22, rank: 2 },
        { suit: 23, rank: 14 }
      ]
      history = new history_module.History()
      history.record(@trick1)
      history.record(@trick2)
      history.user_played.north.should.eql(expected_north)
      history.user_played.east.should.eql(expected_east)
      history.user_played.south.should.eql(expected_south)
      history.user_played.west.should.eql(expected_west)

    it "should record when a user is out of a suit", ->
      history = new history_module.History()
      history.record(@trick1)
      history.record(@trick2)
      history.record(@trick3)
      history.player_has_suit[types.Position.SOUTH][types.Suit.SPADES].should.equal(false)

  describe "#cards_left_above", ->
    it "should return the number of cards in the suit above the card", ->
      history = new history_module.History()
      history.record(@trick1)
      history.record(@trick2)
      history.record(@trick3)
      history.cards_left_above(@tenDiamonds).should.equal(2)

  describe "#cards_left_below", ->
    it "should return the number of cards in the suit below the card", ->
      history = new history_module.History()
      history.record(@trick1)
      history.record(@trick2)
      history.record(@trick3)
      history.cards_left_below(@tenDiamonds).should.equal(6)
