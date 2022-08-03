require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(published_date, id = SecureRandom.uuid, on_spotify: true, archived: false)
    super(published_date, id, archived: archived)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    @published_date.to_date.year < Date.today.year - 10 && @on_spotify
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'published_date' => @published_date.to_date,
      'id' => @id,
      'archived' => @archived,
      'on_spotify' => @on_spotify
    }.to_json(*args)
  end

  def self.json_create(musicalbum)
    year, month, day = musicalbum['published_date'].split('-')
    new(
      musicalbum['on_spotify'], DateTime.new(year1.to_i, month1.to_i, day1.to_i),
      DateTime.new(year.to_i, month.to_i, day.to_i), musicalbum['id'], archived: musicalbum['archived']
    )
  end
end
