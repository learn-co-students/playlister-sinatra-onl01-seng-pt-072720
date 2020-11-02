class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :genres

    def slug
        self.name.strip.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Song.all.find{|artist| artist.slug == slug}
    end
end