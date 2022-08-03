require 'securerandom'

class Label
  attr_accessor :title, :color, :items
  attr_reader :id

  def initialize(title, color, id = SecureRandom.uuid)
    @title = title
    @color = color
    @id = id
    @items = []
  end

  def add_item(item)
    item.label = self if item.class != String
    @items << item
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'title' => @first_name,
      'color' => @last_name,
      'id' => @id,
      'items' => @items.map(&:id)
    }.to_json(*args)
  end

  def self.json_create(label)
    newlabel = new(
      label['title'], label['color'], label['id']
    )
    label['items'].each { |item| newlabel.add_item(item) }
    newlabel
  end
end
