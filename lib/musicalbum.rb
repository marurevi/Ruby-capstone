require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(published_date, id = SecureRandom.uuid, on_spotify: true, archived: false)
    super(published_date, id, archived: archived)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    true if @on_spotify
  end

  # def to_s
  #   "Music Album name: #{@label.title}\npublished date: #{@published_date}\nHosted on Spotify: #{@on_spotify}"
  # end
end
