class AddAuthenticationTokenColToUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :text
    add_column :users, :authentication_token_created_at, :datetime

    remove_column :users, :tokens, :json

    add_index :users, :authentication_token, unique: true
  end
end
