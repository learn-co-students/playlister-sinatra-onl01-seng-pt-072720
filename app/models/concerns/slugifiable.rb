class Slugifiable < ActiveRecord::Base
    module InstanceMethod
        def slug
            self.name.downcase.split.join("-")
        end 
    end 
        
    module ClassMethod
        def find_by_slug(slug)
            # slug.split("-").collect{|x|x.capitalize}.join(" ")
            slug_arr = []
            
            self.class.all.map do |instance|
                slug_arr << instance.name.slug
            end 

            if slug_arr.include?(slug)
                self.name 
            end 
        end 
    end 
end