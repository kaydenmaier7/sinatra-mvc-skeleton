class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :username, { limit: 128 }
      t.string :email, { limit: 128 }
      t.string :hashed_password, { limit: 64 }

      t.timestamps(null: false)
    end

  end
end
