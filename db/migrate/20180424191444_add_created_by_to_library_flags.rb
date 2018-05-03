class AddCreatedByToLibraryFlags < ActiveRecord::Migration[5.1]
  def change
    add_column :library_flags, :created_by, :integer
  end
end
