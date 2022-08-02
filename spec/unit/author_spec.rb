require_relative '../../lib/author'
require_relative '../../lib/item'

fdescribe 'An author' do
  let(:author) { Author.new('first-name', 'last-name', 'the-author-id') }
  let(:item) { Item.new(Date.new(2011, 12, 25), 'the-item-id') }

  it 'should be initialized as an author object with properties' do
    expect(author).to be_a Author
    expect(author.first_name).to eq 'first-name'
    expect(author.last_name).to eq 'last-name'
    expect(author.id).to eq 'the-author-id'
    expect(author.items.size).to eq 0
  end

  it 'should have items added to the items property in the add_item method' do
    author.add_item(item)
    expect(author.items.size).to eq 1
  end
end
