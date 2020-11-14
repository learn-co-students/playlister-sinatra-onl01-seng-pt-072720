class GenreController < ApplicationController

    get '/genres' do 
        erb :"genres/index"
    end

    
end