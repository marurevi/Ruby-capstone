require 'json'
require 'date'

require_relative 'game'

module Loaders
  def load_games(file_name, games = [])
    return [] unless File.exist?(file_name)

    file = JSON.parse(File.read(file_name), object_class: Hash)
    file.each do |game|
      props = JSON.parse(game)['props']
      genre = props[0]
      author = props[1]
      source = props[2]
      label = props[3]
      published_date = props[4]
      year, month, day = published_date.split('-')
      id = props[5]
      archived = props[6]
      multiplayer = props[7]
      last_played_at = props[8]
      year1, month1, day1 = last_played_at.split('-')
      games << Game.new([genre, author, source,
                         label, multiplayer, DateTime.new(year1.to_i, month1.to_i, day1.to_i)],
                        DateTime.new(year.to_i, month.to_i, day.to_i))
    end
    games
  end

  def load_all(games_file)
    games = load_games(games_file)
    [games]
  end
end
