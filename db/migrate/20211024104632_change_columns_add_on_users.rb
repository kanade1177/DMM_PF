class ChangeColumnsAddOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :introduction, :string, default: "", null: false
  end
end
