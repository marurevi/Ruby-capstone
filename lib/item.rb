require 'securerandom'
require 'date'

class Item
  attr_reader :id, :genre, :author, :source, :label
  attr_accessor :published_date, :archived

  def initialize(published_date, id = SecureRandom.uuid)
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
    @published_date = published_date
    @id = id
    @archived = false
  end

  def author=(new_author)
    @author = new_author
    new_author.add_item(self)
  end

  def genre=(new_genre)
    @genre = new_genre
    new_genre.add_item(self)
  end

  def source=(new_source)
    @source = new_source
    new_source.add_item(self)
  end

  def label=(new_label)
    @label = new_label
    new_label.add_item(self)
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    @published_date.to_date < Date.today.year - 10
  end
end
