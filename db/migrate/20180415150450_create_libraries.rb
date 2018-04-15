class CreateLibraries < ActiveRecord::Migration[5.1]
  def change
    create_table :libraries do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :lat
      t.decimal :lon
      t.string :name

      t.timestamps
    end
  end
end
