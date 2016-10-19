class CreateScores < ActiveRecord::Migration
  def change

    create_table :scores do |t|
      t.string :email, { limit: 128 }
      t.float :score

      t.timestamps(null: false)
    end

  end
end
