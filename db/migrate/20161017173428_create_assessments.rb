class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :user_id
      t.string :name, { limit: 128 }
      t.string :key, { limit: 64 }

      t.timestamps(null: false)
    end
  end
end
