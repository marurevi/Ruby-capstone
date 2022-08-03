class Genre
  attr_accessor :items
  attr_reader :name

  def initialize(name)
    @name = name
    @id = rand 1..1000
    @items = []
  end

  def add_item(item)
    @items.push(item) unless @items.include?(item)
    item.add_genre(self)
  end

  def to_s
    "Name of Genre: #{@name}"
  end
end
