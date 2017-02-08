class Changecolumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :senderid, :receiverid
  end
end
