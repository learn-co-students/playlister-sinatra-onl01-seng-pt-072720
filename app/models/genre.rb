class Genre < ActiveRecord::Base
    
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        self.name.downcase.gsub(" ", "-")   
      end
    
    def self.find_by_slug(slug)
      # name = slug.gsub("-", " ").titleize
      # Genre.find_by(name: name)
      Genre.all.find do |genre|
        genre.slug == slug
      end
    end
end