require_relative '../../lib/item'

describe Item do
  before(:all) do 
    @item = Item.new('the-item-id')
  end
  
  context 'When testing the item class' do
    it 'should instantiate the item class with the properties' do
      expect(@item).to be_truthy
      expect(@item.id).to eq 'the-item-id'
    end
  end
end
