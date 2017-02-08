class RemoveUtypeFromIrbs < ActiveRecord::Migration[5.0]
  def change
    remove_column :irbs, :utype, :string
  end
end
