require_relative '../../lib/book'
require 'date'

describe 'A book' do
  date = DateTime.new(2015, 12, 25)
  let(:book) { Book.new date, 'the-item-id' }

  it 'should be an instance of the item' do
    expect(book.is_a?(Item)).to be true
  end
  it 'should have a published date' do
    expect(book.published_date).to eq date
  end
  it 'should have a id' do
    expect(book.id).to eq 'the-item-id'
  end
  it 'should overwrite parent method if cover_state is bad' do
    book.cover_state = 'bad'
    expect(book.can_be_archived?).to be true
  end
end
