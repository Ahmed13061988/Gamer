class Gamer < ActiveRecord::Base 
    has_many :games 
    has_secure_password 
end 