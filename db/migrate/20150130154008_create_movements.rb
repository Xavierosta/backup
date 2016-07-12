class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.float :tmin
      t.float :tmax
      t.text :destination
      t.text :source

      t.timestamps
    end
  end
end
