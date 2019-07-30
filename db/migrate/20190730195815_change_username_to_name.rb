class ChangenameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:users, :name, :name)
  end
end
