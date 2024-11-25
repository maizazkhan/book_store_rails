class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
  def change
    # If the user model already exists, this will add necessary columns
    change_table :users do |t|
      t.string :uid,      null: false, default: ""
      t.string :provider, null: false, default: "email"
      t.json :tokens
    end
  end
end
