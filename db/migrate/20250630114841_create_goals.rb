class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.decimal :target_amount
      t.date :due_date
      t.decimal :progress
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
