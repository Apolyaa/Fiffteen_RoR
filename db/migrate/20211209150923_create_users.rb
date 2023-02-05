class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :remember_token

      t.timestamps
    end
    add_index :users, :remember_token
  end
end
