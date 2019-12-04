class AddRemembermeTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :remember_me, :string
  end
end
