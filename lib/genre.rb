class Genre
  attr_accessor :name, :items
  attr_reader :id

  def initialize(name, id = SecureRandom.uuid)
    @name = name
    @id = id
    @items = []
  end

  def add_item(item)
    item.genre = self if item.class != String
    @items << item
  end
end
