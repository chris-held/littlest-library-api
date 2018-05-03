class AddImageToLibraries < ActiveRecord::Migration[5.1]
  def change
    add_column :libraries, :image, :string
  end
end
