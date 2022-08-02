require_relative '../../lib/genre'

describe Genre do
    before(:each) do
      @genre = Genre.new('Hip-Hop')
    end

    it 'should have its own attributes' do
      expect(@genre).to have_attributes(name: "Hip-Hop")
    end

    it 'should be an instance of Genre' do
        expect(@genre).to be_instance_of Genre
      end
  end