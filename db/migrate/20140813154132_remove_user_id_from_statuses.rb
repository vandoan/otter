class RemoveUserIdFromStatuses < ActiveRecord::Migration
  def change
    remove_column :statuses, :user_id, :integer
  end
end
