require_relative '../../lib/musicalbum'
require 'date'

describe MusicAlbum do
  before :each do
    @musicalbum = MusicAlbum.new(
     DateTime.new(2011, 12, 25), 'the-musicalbum-id', on_spotify: true, archived: false
    )
  end

  context 'When testing the musicalbum class' do
    it 'should instantiate the item class with the properties' do
      expect(@musicalbum.published_date.is_a?(DateTime.new(2011, 12, 25))).to be true
      expect(@musicalbum.on_spotify).to be true
      expect(@musicalbum.archived).to eq false
    end
  end
end
