require 'securerandom'

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
end
