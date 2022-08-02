require_relative 'item'

# class MusicAlbum < Item
# #   attr_accessor :on_spotify

# #   def initialize(published_date, on_spotify: true)
# #     super(published_date, archived: archived)
# #     @on_spotify = on_spotify
# #   end
#   attr_accessor :on_spotify, :name, :genre, :publish_date

#   def initialize(name, genre, publish_date, on_spotify)
#     @name = name
#     @genre = genre
#     super(publish_date)
#     @on_spotify = on_spotify
#   end

#   def can_be_archived?
#     super && @on_spotify
#   end
# end
class MusicAlbum < Item
    attr_accessor :on_spotify
  
    def initialize(published_date, on_spotify: true, archived: false)
      super(published_date, archived: archived)
      @on_spotify = on_spotify
    end
  
    def can_be_archived?
      super && @on_spotify
    end
  end