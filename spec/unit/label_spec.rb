require_relative '../../lib/label'
require_relative '../../lib/item'

fdescribe 'A label' do
  date = Date.new(2011, 12, 25)

  let(:label) { Label.new('Title', 'color', date, 'the-label-id') }
  let(:item) { Item.new(date, 'the-item-id') }

  it 'should be initialized as an label object with properties' do
    expect(label).to be_a Label
    expect(label.title).to eq 'Title'
    expect(label.color).to eq 'color'
    expect(label.id).to eq 'the-label-id'
    expect(label.items.size).to eq 0
  end

  it 'should have items added to the items property in the add_item method' do
    label.add_item(item)
    expect(label.items.size).to eq 1
  end
end
