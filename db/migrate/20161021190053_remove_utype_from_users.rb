class RemoveUtypeFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :utype, :string
  end
end
