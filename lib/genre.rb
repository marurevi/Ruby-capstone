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

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'name' => @name,
      'id' => @id,
      'items' => @items.map(&:id)
    }.to_json(*args)
  end

  def self.json_create(genre)
    newgenre = new(
      genre['name'], genre['id']
    )
    genre['items'].each { |item| newgenre.add_item(item) }
    newgenre
  end
end
