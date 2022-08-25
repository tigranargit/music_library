require 'album_repository'

RSpec.describe AlbumRepository do
      
      def reset_albums_table
            seed_sql = File.read('spec/seeds_albums.sql')
            connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
            connection.exec(seed_sql)
      end
      
      before(:each) do
            reset_albums_table
      end 
      
      it 'returns the list of albums' do

            repo = AlbumRepository.new

            albums = repo.all
            expect(albums.length).to eq 2
            expect(albums.first.id).to eq '1'
            expect(albums.first.title).to eq 'Doolittle'
            expect(albums.first.artist_id).to eq '1'
      end 

      it 'returns Doolitle as a single album' do 

            repo = AlbumRepository.new

            album = repo.find(1)
            expect(album.title).to eq 'Doolittle'
            expect(album.release_year).to eq '1989'
            expect(album.artist_id).to eq '1'
      end 

      it 'returns Surfer Rosa as a single album' do 

            repo = AlbumRepository.new

            album = repo.find(2)
            expect(album.title).to eq 'Surfer Rosa'
            expect(album.release_year).to eq '1988'
            expect(album.artist_id).to eq '1'
      end 

      it 'creates a new album' do
            repo = AlbumRepository.new

            album = Album.new
            album.title = 'Greatest Hits'
            album.release_year = '2000'
            album.artist_id = '1'

            repo.create(album)

            albums = repo.all

            last_album = albums.last
            expect(last_album.title).to eq 'Greatest Hits'
            expect(last_album.release_year).to eq '2000'
            expect(last_album.artist_id).to eq '1'
      end 
end 