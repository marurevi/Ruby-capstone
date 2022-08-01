require_relative '../../lib/item'

describe Item do
  before(:all) do
    @item = Item.new(
      ['some genre', 'some author', 'some source',
       'some label'], DateTime.new(2011, 12, 25), 'the-item-id', archived: false
    )
  end

  context 'When testing the item class' do
    it 'should instantiate the item class with the properties' do
      expect(@item).to be_truthy
      expect(@item.id).to eq 'the-item-id'
      expect(@item.genre).to eq 'some genre'
      expect(@item.author).to eq 'some author'
      expect(@item.source).to eq 'some source'
      expect(@item.label).to eq 'some label'
      expect(@item.published_date.is_a?(DateTime)).to be true
      expect(@item.archived).to eq false
    end
    it 'should return true if published_date is older than 10 years' do
      expect(@item.could_be_archived?).to be true
    end
  end
end
