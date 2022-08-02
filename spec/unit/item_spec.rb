require_relative '../../lib/item'

describe Item do
  date = Date.new(2015, 12, 25)
  let(:item) { Item.new date, 'the-item-id' }

  context 'When testing the item class' do
    it 'should instantiate the item class with the properties' do
      expect(item).to be_truthy
      expect(item.id).to eq 'the-item-id'
      expect(item.published_date.is_a?(DateTime)).to be true
      expect(item.archived).to eq false
    end
    it 'could be archived if published_date is older than 10 years' do
      expect(item.could_be_archived?).to be true
    end
    it 'should be moved to archive if can be archived' do
      expect(item.move_to_archive).to be true
    end
  end
end
