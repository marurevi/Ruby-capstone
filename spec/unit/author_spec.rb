require_relative '../../lib/author'

fdescribe 'An author' do
  let(:author) { Author.new('first-name', 'last-name', 'the-author-id') }

  it 'should be initialized as an author object with properties' do
    expect(author.is_a?(Author)).to be true
    expect(author.first_name).to eq 'first-name'
    expect(author.last_name).to eq 'last-name'
    expect(author.author_id).to eq 'the-author-id'
    expect(author.items.size).to eq 0
  end

  it 'should have items added to the items property in the add_item method' do
    author.add_item('some item')
    expect(author.items.size).to eq 1
    author.add_item('some other item')
    expect(author.items.size).to eq 2
  end
end
