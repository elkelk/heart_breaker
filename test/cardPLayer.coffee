player = require('../cardPlayer')
types = require "../lib/hearts_types"
should = require("should")

describe "CardPlayer", ->
  describe "#twoClubs", ->
    beforeEach ->
      @twoClubs = { suit: types.Suit.CLUBS, rank: types.Rank.TWO }
      @threeClubs = { suit: types.Suit.CLUBS, rank: types.Rank.THREE }
      @fourClubs = { suit: types.Suit.CLUBS, rank: types.Rank.FOUR }
    it "should return undefined if the hand doesn't contain the 2 of clubs", ->
      cardPlayer = new player.CardPlayer([@threeClubs, @fourClubs])
      should.not.exist(cardPlayer.twoClubs())

    it "should return the card if the hand has the 2 of clubs", ->
      cardPlayer = new player.CardPlayer([@twoClubs, @fourClubs])
      cardPlayer.twoClubs().should.equal(@twoClubs)

