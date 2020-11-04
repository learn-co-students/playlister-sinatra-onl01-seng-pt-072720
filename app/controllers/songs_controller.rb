require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        @songs = Song.all
        @genres = Genre.all
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    post '/songs' do
        # binding.pry
        @song = Song.find_or_create_by(name: params[:song][:name])
        
        @genre = Genre.find_or_create_by(id: params[:genres][0])
        @song.genres << @genre

        @artist = Artist.find_or_create_by(name: params[:artist][:name])
        @artist.songs << @song
       
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
        # binding.pry
        @song = Song.find_by_slug(params[:slug])
        @song.update(name: params[:song][:name])
        
        @genre = Genre.find_or_create_by(id: params[:genres][0])
        @song.genres.clear 
        @song.genres << @genre

        @artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.artist = @artist
        @artist.songs << @song

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end
end