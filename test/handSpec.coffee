hand_lib = require('../hand')
types = require "../lib/hearts_types"
should = require("should")

describe "Hand", ->
  describe "#twoClubs", ->
    beforeEach ->
      @twoClubs = { suit: types.Suit.CLUBS, rank: types.Rank.TWO }
      @threeClubs = { suit: types.Suit.CLUBS, rank: types.Rank.THREE }
      @fourClubs = { suit: types.Suit.CLUBS, rank: types.Rank.FOUR }

    it "should return undefined if the hand doesn't contain the 2 of clubs", ->
      my_hand = new hand_lib.Hand([@threeClubs, @fourClubs])
      should.not.exist(my_hand.twoClubs())

    it "should return the card if the hand has the 2 of clubs", ->
      my_hand = new hand_lib.Hand([@twoClubs, @fourClubs])
      my_hand.twoClubs().should.equal(@twoClubs)

  describe "#queenSpades", ->
    beforeEach ->
      @aceSpades =   { suit: types.Suit.SPADES,   rank: types.Rank.ACE }
      @aceDiamonds = { suit: types.Suit.DIAMONDS, rank: types.Rank.ACE }
      @queenSpades = { suit: types.Suit.SPADES,   rank: types.Rank.QUEEN }

    it "should return undefined if the hand doesn't contain the 2 of clubs", ->
      my_hand = new hand_lib.Hand([@aceSpades, @aceDiamonds])
      should.not.exist(my_hand.queenSpades())

    it "should return the card if the hand has the 2 of clubs", ->
      my_hand = new hand_lib.Hand([@aceDiamonds, @queenSpades])
      my_hand.queenSpades().should.equal(@queenSpades)

  describe "#hasCard", ->
    beforeEach ->
      @twoClubs = { suit: types.Suit.CLUBS, rank: types.Rank.TWO }
      @threeClubs = { suit: types.Suit.CLUBS, rank: types.Rank.THREE }
      @fourClubs = { suit: types.Suit.CLUBS, rank: types.Rank.FOUR }

    it "should return undefined if the hand doesn't contain the the card", ->
      my_hand = new hand_lib.Hand([@threeClubs, @fourClubs])
      should.not.exist(my_hand.hasCard(types.Rank.FIVE, types.Suit.CLUBS))

    it "should return the card if the hand has the card", ->
      my_hand = new hand_lib.Hand([@twoClubs, @fourClubs])
      my_hand.hasCard(types.Rank.FOUR, types.Suit.CLUBS).should.equal(@fourClubs)

  describe "#play", ->
    beforeEach ->
      @twoClubs = { suit: types.Suit.CLUBS, rank: types.Rank.TWO }
      @threeClubs = { suit: types.Suit.CLUBS, rank: types.Rank.THREE }
      @fourClubs = { suit: types.Suit.CLUBS, rank: types.Rank.FOUR }

    it "should move the card out of hand and into the played object", ->
      my_hand = new hand_lib.Hand([@twoClubs, @threeClubs, @fourClubs])
      my_hand.play(@twoClubs)
      my_hand.hand.should.eql([@threeClubs, @fourClubs])
      my_hand.played.should.eql([@twoClubs])

