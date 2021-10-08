class ChangeColumnsAddNotnullOnTweets < ActiveRecord::Migration[5.2]
  def change
    change_column :tweets, :erea_id, :integer, null: false
  end
end
