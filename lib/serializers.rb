module Serializers
  def save(games, authors)
    files = [
      { name: 'games', payload: games },
      { name: 'authors', payload: authors }
    ]

    files.each do |file|
      File.open("data/#{file[:name]}.json", 'w') do |f|
        data_hash = { file[:name] => file[:payload] }
        json = JSON.pretty_generate(data_hash)
        f.write(json)
      end
    end
  end
end
