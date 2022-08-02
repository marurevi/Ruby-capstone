require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :published_date
  attr_reader :id, :archived
  
  def initialize(published_date, id = SecureRandom.uuid)
    @published_date = published_date
    @id = id
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    @published_date.to_date < Date.today.year - 10
    archived = true if can_be_archived? == true
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
