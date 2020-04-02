class CreateGameTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name 
      t.string :publisher
      t.string :rate 
      t.string :gamer_id 
   end
 end
end 
