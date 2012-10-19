class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps # the timestamp adds the created_at and updated_at columns
      
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
