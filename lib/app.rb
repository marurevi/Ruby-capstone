require_relative 'game'

class App
  attr_reader :games

  def initialize
    @games = []
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
    return unless %w[4 12].include? command

    { '4' => -> { list_games },
      '12' => -> { add_game } }[command].call
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
    puts 'There are no games yet!' if @games.empty?
    @games.each.with_index do |game, i|
      puts "#{i}) [Game] The #{game.genre} game by #{game.author} was released in #{game.published_date.to_date}."
    end
  end

  def add_game
    genre = [(print 'Genre: '), gets.rstrip][1]
    author = [(print 'Author: '), gets.rstrip][1]
    source = [(print 'Source: '), gets.rstrip][1]
    label = [(print 'Label: '), gets.rstrip][1]
    published_date = [(print 'Published date (yyyy-mm-dd): '), gets.rstrip][1]
    year, month, day = published_date.split('-')
    multiplayer = [(print 'Multiplayer: '), gets.rstrip][1]
    last_played_at = [(print 'Last played at (yyyy-mm-dd): '), gets.rstrip][1]
    year1, month1, day1 = last_played_at.split('-')
    begin
      game = Game.new([genre, author, source,
        label, multiplayer, DateTime.new(year1.to_i, month1.to_i, day1.to_i)],
        DateTime.new(year.to_i, month.to_i, day.to_i))
    rescue
      puts 'Could not create game with provided info!'
      return
    end
    puts 'Game created successfully!'
    @games << game
  end
end
