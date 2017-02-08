class AddUlidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ulid, :string
  end
end
