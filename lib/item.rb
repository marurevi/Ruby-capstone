require 'securerandom'
require 'date'

class Item
  attr_reader :id, :genre, :author, :source, :label, :published_date
  attr_accessor :archived

  def initialize(objects, published_date, id = SecureRandom.uuid, archived: false)
    @genre = objects[0]
    @author = objects[1]
    @source = objects[2]
    @label = objects[3]
    @published_date = published_date
    @id = id
    @archived = archived
  end

  def can_be_archived?
    @published_date.to_date < Date.today - 10
  end

  def move_to_archive
    @archived = true if can_be_archived? == true
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'props' => [@id, @age, @name, @parent_permission]
    }.to_json(*args)
  end

  def json_create(object)
    new(*object['props'])
  end
end
