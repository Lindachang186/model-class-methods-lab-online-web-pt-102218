class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

    def self.first_five 
      self.all[0..4]
    end 

    def self.dinghy 
      self.where("length < ?", 19)
    end 

    def self.ship 
      self.where("length >= ?", 20)
    end 

    def self.last_three_alphabetically 
      self.all.sort_by{|m| m[:name]}.last(3).reverse
    end 

    def self.without_a_captain
      self.where(captain: nil)
    end 

    def self.sailboats 
      self.all.select {|boat| boat.classifications.exists?(name: "Sailboat")}
    end 

    def self.with_three_classifications
      self.all.select do |boat|
        if boat.classifications.size == 3 
          boat 
        end 
      end 
    end 


end
