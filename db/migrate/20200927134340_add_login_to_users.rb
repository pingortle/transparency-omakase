class AddLoginToUsers < ActiveRecord::Migration[6.0]
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :login, :string
    add_index :users, :login, unique: true
    remove_index :users, :email

    User.find_each do |user|
      user.login = user.email.gsub(/[^a-zA-Z0-9_]/, "_")
      user.save!
    end

    change_column :users, :login, :string, null: false
  end
end
