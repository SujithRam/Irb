class AddUtypeToIrbs < ActiveRecord::Migration[5.0]
  def change
    add_column :irbs, :utype, :string
  end
end
