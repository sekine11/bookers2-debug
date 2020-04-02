class AddIndexFavorites < ActiveRecord::Migration[5.2]
  def change
  	add_index :favorites, :user_id
    add_index :favorites, :book_id
  	add_index :favorites, [:user_id, :book_id], unique: true
  end
end
