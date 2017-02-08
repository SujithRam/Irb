class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :msg
      t.references :user, foreign_key: true
      t.string :irbappid
      t.string :senderid
      
      t.timestamps
    end
    add_index :messages, [:user_id, :created_at]
  end
end
