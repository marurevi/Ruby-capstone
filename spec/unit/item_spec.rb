# Your spec stuff goes here...
require_relative '../../lib/item'

describe Item do
  before(:all) do 
    @item = Item.new
  end
  
  context 'When testing the item class' do
    it 'should instantiate the item class with the properties' do
      expect(@item).to be_truthy
    end
  end
end
