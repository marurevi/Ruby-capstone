class App
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
    return unless %w[].include? command

    { 1 => -> {} }[command].call
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
end
