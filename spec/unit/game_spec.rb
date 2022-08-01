require_relative '../../lib/game'

describe Game do
  before(:all) do
    @game = Game.new(
      ['some genre', 'some author', 'some source',
       'some label', 'multiplayer', DateTime.new(2019, 2, 15)],
      DateTime.new(2017, 12, 25), 'the-game-id', archived: false
    )
  end

  context 'When testing the game class' do
    it 'should instantiate the game class with the properties' do
      expect(@game).to be_truthy
      expect(@game.id).to eq 'the-game-id'
      expect(@game.genre).to eq 'some genre'
      expect(@game.author).to eq 'some author'
      expect(@game.source).to eq 'some source'
      expect(@game.label).to eq 'some label'
      expect(@game.published_date.is_a?(DateTime)).to be true
      expect(@game.archived).to eq false
      expect(@game.multiplayer).to eq 'multiplayer'
      expect(@game.last_played_at.is_a?(DateTime)).to be true
    end

    it 'should return true if published_date is older than 10 years and last played at is older than 2 years' do
      expect(@game.can_be_archived?).to be true
    end
  end
end
