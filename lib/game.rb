require_relative 'item'

class Game < Item
  attr_reader :multiplayer, :last_played_at

  def initialize(objects, published_date, id = SecureRandom.uuid, archived: false)
    super(objects, published_date, id, archived: archived)
    @multiplayer = objects[4]
    @last_played_at = objects[5]
  end

  def can_be_archived?
    @published_date.to_date < Date.today - 10 && @last_played_at.to_date < Date.today - 2
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'props' => [@genre, @author, @source, @label, @published_date.to_date, @id, @archived, @multiplayer,
                  last_played_at.to_date]
    }.to_json(*args)
  end
end
