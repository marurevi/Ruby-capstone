require_relative '../../lib/item'

describe Item do
  date = Date.new(2011, 12, 25)
  let(:item) { Item.new(date, 'the-item-id') }

  context 'When testing the item class' do
    it 'should instantiate the item class with the properties' do
      expect(item).to be_truthy
      expect(item.id).to eq 'the-item-id'
      expect(item.published_date.is_a?(Date)).to be true
      expect(item.archived).to eq false
    end
    it 'should be moved to archive if can be archived' do
      expect(item.move_to_archive).to be true
    end
  end
end
