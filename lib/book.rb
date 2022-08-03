require_relative 'item'
require 'securerandom'

class Book < Item
  attr_reader :id
  attr_accessor :cover_state, :archived, :genre, :author, :label, :published_date

  def initialize(published_date, cover_state = 'good', id = SecureRandom.uuid, archived: false)
    super(published_date, id, archived: archived)
    @published_date = published_date
    @id = id
    @cover_state = cover_state
    move_to_archive
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'published_date' => @published_date.to_date,
      'id' => @id,
      'archived' => @archived,
      'cover_state' => @cover_state
    }.to_json(*args)
  end

  def self.json_create(book)
    year, month, day = book['published_date'].split('-')
    new(
      Date.new(year.to_i, month.to_i, day.to_i),
      book['cover_state'], book['id'], archived: book['archived']
    )
  end

  private

  def can_be_archived?
    @published_date.to_date.year < Date.today.year - 10 || @cover_state == 'bad'
  end
end
