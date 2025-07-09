class AddUserToCategories < ActiveRecord::Migration[8.0]
  def change
    drop_table :categories, if_exists: true, force: :cascade

    create_table :categories do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
