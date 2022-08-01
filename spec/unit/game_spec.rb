require_relative '../../lib/game'

describe Game do
  before(:all) do
    @item = Game.new(
      ['some genre', 'some author', 'some source',
       'some label'], DateTime.new(2017, 12, 25), 'the-item-id', archived: false
    )
  end

  context 'When testing the game class' do
    it 'should instantiate the game class with the properties' do
      expect(@item).to be_truthy
      expect(@item.id).to eq 'the-item-id'
      expect(@item.genre).to eq 'some genre'
      expect(@item.author).to eq 'some author'
      expect(@item.source).to eq 'some source'
      expect(@item.label).to eq 'some label'
      expect(@item.published_date.is_a?(DateTime)).to be true
      expect(@item.archived).to eq false
    end
  end
end
