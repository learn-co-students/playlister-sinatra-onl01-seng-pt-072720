class Artist::Slugifiable < ActiveRecord::Base
    include Slugifiable::InstanceMethods
    
    has_many :songs
    has_many :genres, through: :songs
end
