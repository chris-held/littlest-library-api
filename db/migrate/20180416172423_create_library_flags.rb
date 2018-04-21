class CreateLibraryFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :library_flags do |t|
      t.references :library, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
