class AddFavoriteBooksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_books, :string
  end
end
