class CreateBirdSightings < ActiveRecord::Migration
  def change
    create_table :bird_sightings do |t|
      t.string :name
      t.string :location
      t.float :latitude
      t.float :longitude
      t.date :sightingDate

      t.timestamps
    end
  end
end
