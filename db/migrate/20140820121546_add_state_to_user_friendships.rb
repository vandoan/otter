class AddStateToUserFriendships < ActiveRecord::Migration
  def change
    add_column :user_friendships, :state, :string
  end
end
