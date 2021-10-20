class AddColumnsToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :latitude, :float
    add_column :tweets, :longitude, :float
    add_column :tweets, :address, :string
  end
end
