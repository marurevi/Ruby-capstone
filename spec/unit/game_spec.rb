require_relative '../../lib/game'

describe Game do
  last_played = Date.new(2019, 12, 25)
  published = Date.new(2011, 12, 25)
  let(:game) { Game.new('yes', last_played, published, 'the-game-id') }

  context 'When testing the game class' do
    it 'should instantiate the game class with the properties' do
      expect(game).to be_truthy
      expect(game.multiplayer).to eq 'yes'
      expect(game.last_played_at.is_a?(Date)).to be true
      expect(game.published_date.is_a?(Date)).to be true
      expect(game.id).to eq 'the-game-id'
      expect(game.archived).to eq false
    end

    it 'should return true if published_date is older than 10 years and last played at is older than 2 years' do
      expect(game.can_be_archived?).to be true
    end
  end
end
