require 'securerandom'
require 'date'

class Item
  attr_reader :id, :genre, :author, :source, :label, :published_date
  attr_accessor :archived

  def initialize(objects, published_date, id = SecureRandom.uuid, archived: false)
    @id = id
    @genre = objects[0]
    @author = objects[1]
    @source = objects[2]
    @label = objects[3]
    @published_date = published_date
    @archived = archived
  end

  def can_be_archived?
    @published_date.to_date < Date.today - 10
  end

  def move_to_archive
    @archived = true if could_be_archived? == true
  end
end
