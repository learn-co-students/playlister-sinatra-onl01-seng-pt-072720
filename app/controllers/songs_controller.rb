class SongsController < ApplicationController
    get '/songs' do
        erb :'songs/index'
    end
    
    get '/songs/new' do 
        erb :'songs/new'
    end 

    post '/songs' do 
        @song = Song.new(params[:song])
        @artist = Artist.new(params[:artist])

        redirect to "/songs/#{@song.slug}"
    end 

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end 
end 