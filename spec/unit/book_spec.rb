require_relative '../../lib/item'
fdescribe 'A book' do
  it 'should be an instance of the item' do
    expect(@object.should(be_an_instance_of(Item)))
  end
  it 'should overwrite parent method if cover_state is bad'
end
