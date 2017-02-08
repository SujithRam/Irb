class AddCommitteeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :committee, :boolean, :default => false
  end
end
