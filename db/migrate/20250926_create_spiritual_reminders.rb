class CreateSpiritualReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :spiritual_reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reminder_type, null: false
      t.string :frequency, null: false
      t.boolean :active, default: true
      t.datetime :next_reminder_date
      t.datetime :last_sent_at
      t.json :preferences

      t.timestamps
    end

    add_index :spiritual_reminders, :reminder_type
    add_index :spiritual_reminders, :next_reminder_date
    add_index :spiritual_reminders, [:user_id, :active]
  end
end