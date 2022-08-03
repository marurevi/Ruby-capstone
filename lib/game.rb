require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at, published_date, id = SecureRandom.uuid, archived: false)
    super(published_date, id, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    @published_date.year < Date.today.year - 10 && @last_played_at.year < Date.today.year - 2
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'published_date' => @published_date.to_date,
      'id' => @id,
      'archived' => @archived,
      'multiplayer' => @multiplayer,
      'last_played_at' => @last_played_at.to_date
    }.to_json(*args)
  end

  def self.json_create(game)
    year, month, day = game['published_date'].split('-')
    year1, month1, day1 = game['last_played_at'].split('-')
    new(
      game['multiplayer'], DateTime.new(year1.to_i, month1.to_i, day1.to_i),
      DateTime.new(year.to_i, month.to_i, day.to_i), game['id'], archived: game['archived']
    )
  end
end
