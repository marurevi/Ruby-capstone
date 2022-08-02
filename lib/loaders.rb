require 'json'

module Loaders
  def load(file)
    File.open(file) { |f| JSON.parse(f.read, create_additions: true) }
  end
end
