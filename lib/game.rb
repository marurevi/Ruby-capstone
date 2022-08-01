require_relative 'item'

class Game < Item
  attr_reader :multiplayer, :last_played_at

  def initialize(objects, published_date, id = SecureRandom.uuid, archived: false)
    super(objects, published_date, id, archived: archived)
    @multiplayer = objects[4]
    @last_played_at = objects[5]
  end
end
