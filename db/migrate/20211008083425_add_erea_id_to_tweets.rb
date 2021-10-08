class AddEreaIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :erea_id, :integer
  end
end
