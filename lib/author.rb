require 'securerandom'

class Author
  attr_accessor :first_name, :last_name
  attr_reader :id, :items

  def initialize(first_name, last_name, id = SecureRandom.uuid)
    @first_name = first_name
    @last_name = last_name
    @id = id
    @items = []
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'first_name' => @first_name,
      'last_name' => @last_name,
      'id' => @id,
      'items' => @items.map(&:id)
    }.to_json(*args)
  end

  def self.json_create(author)
    newauthor = new(
      author['first_name'], author['last_name'], author['id']
    )
    author['items'].each { |item| newauthor.add_item(item) }
    newauthor
  end
end
