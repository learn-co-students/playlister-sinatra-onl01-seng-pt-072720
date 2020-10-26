require 'rack-flash'

class SongsController < ApplicationController
    configure do 
        use Rack::Flash
        enable :sessions
    end 

    get '/songs' do
        erb :'songs/index'
    end
    
    get '/songs/new' do 
        erb :'songs/new'
    end 

    post '/songs' do 
        @song = Song.new(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])

        if !params[:genre].nil?
            @song.genre_ids << params[:genre][:id]
        end 

        @song.save

        flash[:message] = "Successfully created song."

        redirect to "/songs/#{@song.slug}"
    end 
    
    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end 

    patch '/songs/:slug' do 
        if !params[:song].keys.include?("genre_ids")
            params[:song]["genre_ids"] = []
        end 
        
        @song = Song.find_by_slug(params[:slug])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        
        if !params[:song][:genre_ids].nil?
            @song.genre_ids << params[:genres]
        end 

        @song.save

        flash[:message] = "Successfully updated song."

        redirect to "/songs/#{@song.slug}"
    end 

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end 

end 