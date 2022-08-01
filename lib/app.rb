require_relative 'game'

class App
  attr_reader :games

  def initialize
    @games = [Game.new(
      ['rpg', 'blizzard', 'some source',
       'some label', 'multiplayer', DateTime.new(2019, 2, 15)],
      DateTime.new(2017, 12, 25), 'the-game-id', archived: false
    )]
  end

  def call_input(first)
    puts "What would you like to do #{first ? 'first' : 'next'}? (1 - 13)"
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List all movies'
    puts '4 - List of games'
    puts '5 - List all genres'
    puts '6 - List all labels'
    puts '7 - List all authors'
    puts '8 - List all sources'
    puts '9 - Add a book'
    puts '10 - Add a music album'
    puts '11 - Add a movie'
    puts '12 - Add a game'
    puts '13 - Exit'
    gets.chomp.strip
  end

  def cases(command)
    return unless %w[4].include? command

    { '4' => -> { list_games } }[command].call
  end

  def action(first)
    command = call_input(first)
    cases(command)
    command
  end

  def run
    puts 'Welcome, choose an option'
    command = action(true)
    while command != '13'
      puts ' '
      command = action(false)
    end
    puts ' '
    puts 'Leaving the catalogue... Goodbye!'
  end

  private

  def list_games
    @games.each.with_index do |game, i|
      puts "#{i}) [Game] The #{game.genre} game by #{game.author} was released in #{game.published_date.to_date}."
    end
  end
end
