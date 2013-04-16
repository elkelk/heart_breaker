player = require('../cardPlayer')
types = require "../lib/hearts_types"
should = require("should")

describe "CardPlayer", ->
  beforeEach ->
    @twoClubs = { suit: types.Suit.CLUBS, rank: types.Rank.TWO }
    @threeClubs = { suit: types.Suit.CLUBS, rank: types.Rank.THREE }
    @fourClubs = { suit: types.Suit.CLUBS, rank: types.Rank.FOUR }

    @threeSpades = { suit: types.Suit.SPADES, rank: types.Rank.THREE }
    @queenSpades = { suit: types.Suit.SPADES, rank: types.Rank.QUEEN }
    @kingSpades = { suit: types.Suit.SPADES, rank: types.Rank.KING }
    @aceSpades = { suit: types.Suit.SPADES, rank: types.Rank.ACE }

    @twoDiamonds = { suit: types.Suit.DIAMONDS, rank: types.Rank.TWO }
    @threeDiamonds = { suit: types.Suit.DIAMONDS, rank: types.Rank.THREE }
    @fourDiamonds = { suit: types.Suit.DIAMONDS, rank: types.Rank.FOUR }

    @twoHearts = { suit: types.Suit.HEARTS, rank: types.Rank.TWO }
    @sixHearts = { suit: types.Suit.HEARTS, rank: types.Rank.SIX }
    @aceHearts = { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
    @hand = [
      @twoClubs,
      @threeClubs,
      @fourClubs,
      { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
      { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
      @twoDiamonds,
      { suit: types.Suit.DIAMONDS, rank: types.Rank.FIVE },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.KING },
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      @aceHearts
    ]

  it "should should play the two of clubs if it is in the hand", ->
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(1, { leader: 3, played: [] } ).should.eql(@twoClubs)

  it "should should play the lowest matching suit if a suit was led and we have that suit", ->
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(1, { leader: 3, played: [] } )
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoHearts ] } ).should.eql(@sixHearts)

  it "shouldn't play hearts the first round", ->
    @hand = [
      { suit: types.Suit.DIAMONDS, rank: types.Rank.TWO },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.THREE },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.FOUR },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.FIVE },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.SEVEN },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.JACK },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.QUEEN },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.KING },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.ACE },
      @twoHearts,
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
    ]
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoClubs ] } ).suit.should.not.eql(types.Suit.HEARTS)

  it "shouldn't play the queen of spades the first round", ->
    @hand = [
      { suit: types.Suit.DIAMONDS, rank: types.Rank.THREE },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.FOUR },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.FIVE },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.SEVEN },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.JACK },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.QUEEN },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.KING },
      { suit: types.Suit.DIAMONDS, rank: types.Rank.ACE },
      @queenSpades,
      @twoHearts,
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
    ]
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoClubs ] } ).should.not.eql(@queenSpades)

  it "should play the highest heart if we are offsuit and we dont have the queen, king, or ace of spades", ->
    @hand = [
      @twoClubs,
      @threeClubs,
      @fourClubs,
      { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
      { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
      { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.KING },
      { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
      @twoHearts,
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      @aceHearts
    ]
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(1, { leader: 3, played: [] } )
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoDiamonds ] } ).should.eql(@aceHearts)

  it "should play the queen of spades if we have it and we are offsuit", ->
    @hand = [
      @threeClubs,
      @fourClubs,
      { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
      { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
      { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.KING },
      { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
      @queenSpades,
      @twoHearts,
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
    ]
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(1, { leader: 3, played: [] } )
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoDiamonds ] } ).should.eql(@queenSpades)

  it "should play the king of spades if we have it and we are offsuit and don't have the queen, or ace", ->
    @hand = [
      @threeClubs,
      @fourClubs,
      { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
      { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
      { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.KING },
      { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
      @kingSpades,
      @twoHearts,
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
    ]
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(1, { leader: 3, played: [] } )
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoDiamonds ] } ).should.eql(@kingSpades)

  it "should play the ace of spades if we have it and we are offsuit and don't have the queen", ->
    @hand = [
      @threeClubs,
      @fourClubs,
      { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
      { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
      { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
      { suit: types.Suit.CLUBS, rank: types.Rank.KING },
      { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
      @kingSpades,
      @aceSpades,
      @sixHearts,
      { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
      { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
    ]
    cardPlayer = new player.CardPlayer(@hand)
    cardPlayer.chooseCard(1, { leader: 3, played: [] } )
    cardPlayer.chooseCard(2, { leader: 4, played: [ @twoDiamonds ] } ).should.eql(@aceSpades)

  describe "leading with the queen in play", ->
    it "should lead the lowest spade if we don't have the ace, king, or queen of spades", ->
      @hand = [
        @threeClubs,
        @fourClubs,
        { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
        { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
        { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.KING },
        { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
        @threeSpades,
        @twoHearts,
        @sixHearts,
        { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
        { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
      ]
      cardPlayer = new player.CardPlayer(@hand)
      cardPlayer.chooseCard(1, { leader: 4, played: [] } )
      cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@threeSpades)

    describe "leading with the ace, king, or queen of spades", ->
      it "should lead diamonds if they are the lowest", ->
        @hand = [
          @threeClubs,
          @fourClubs,
          { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
          { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
          { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
          { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
          { suit: types.Suit.CLUBS, rank: types.Rank.KING },
          { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
          @twoDiamonds,
          @aceSpades,
          @sixHearts,
          { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
          { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
        ]
        cardPlayer = new player.CardPlayer(@hand)
        cardPlayer.chooseCard(1, { leader: 4, played: [] } )
        cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@twoDiamonds)

      it "should lead clubs if they are the lowest", ->
        @hand = [
          @threeClubs,
          @fourClubs,
          { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
          { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
          { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
          { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
          { suit: types.Suit.CLUBS, rank: types.Rank.KING },
          { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
          @fourDiamonds,
          @kingSpades,
          @sixHearts,
          { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
          { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
        ]
        cardPlayer = new player.CardPlayer(@hand)
        cardPlayer.chooseCard(1, { leader: 4, played: [] } )
        cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@threeClubs)

      it "should lead hearts if they are the lowest and they have been broken", ->
        @hand = [
          @threeClubs,
          @fourClubs,
          { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
          { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
          { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
          { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
          { suit: types.Suit.CLUBS, rank: types.Rank.KING },
          { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
          @fourDiamonds,
          @kingSpades,
          @twoHearts,
          { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
          { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
        ]
        cardPlayer = new player.CardPlayer(@hand)
        cardPlayer.history.hearts_broken(true)
        cardPlayer.chooseCard(1, { leader: 4, played: [] } )
        cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@twoHearts)


  describe "leading with the queen gone", ->
    it "should lead diamonds if they are the lowest", ->
      @hand = [
        @threeClubs,
        @fourClubs,
        { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
        { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
        { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.KING },
        { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
        @twoDiamonds,
        @aceSpades,
        @sixHearts,
        { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
        { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
      ]
      cardPlayer = new player.CardPlayer(@hand)
      cardPlayer.history.queenPlayed(true)
      cardPlayer.chooseCard(1, { leader: 4, played: [] } )
      cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@twoDiamonds)

    it "should lead clubs if they are the lowest", ->
      @hand = [
        @threeClubs,
        @fourClubs,
        { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
        { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
        { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.KING },
        { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
        @fourDiamonds,
        @kingSpades,
        @sixHearts,
        { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
        { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
      ]
      cardPlayer = new player.CardPlayer(@hand)
      cardPlayer.history.queenPlayed(true)
      cardPlayer.chooseCard(1, { leader: 4, played: [] } )
      cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@threeClubs)

    it "should lead hearts if they are the lowest and they are broken", ->
      @hand = [
        @threeClubs,
        @fourClubs,
        { suit: types.Suit.CLUBS, rank: types.Rank.FIVE },
        { suit: types.Suit.CLUBS, rank: types.Rank.SEVEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.JACK },
        { suit: types.Suit.CLUBS, rank: types.Rank.QUEEN },
        { suit: types.Suit.CLUBS, rank: types.Rank.KING },
        { suit: types.Suit.CLUBS, rank: types.Rank.ACE },
        @fourDiamonds,
        @kingSpades,
        @twoHearts,
        { suit: types.Suit.HEARTS, rank: types.Rank.EIGHT },
        { suit: types.Suit.HEARTS, rank: types.Rank.ACE }
      ]
      cardPlayer = new player.CardPlayer(@hand)
      cardPlayer.history.queenPlayed(true)
      cardPlayer.history.hearts_broken(true)
      cardPlayer.chooseCard(1, { leader: 4, played: [] } )
      cardPlayer.chooseCard(2, { leader: 3, played: [] } ).should.eql(@twoHearts)

