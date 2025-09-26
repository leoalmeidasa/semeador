class CreateBiblicalReferences < ActiveRecord::Migration[8.0]
  def change
    create_table :biblical_references do |t|
      t.string :verse_reference, null: false
      t.text :verse_text, null: false
      t.string :topic, null: false
      t.string :language, default: 'pt-BR'

      t.timestamps
    end

    add_index :biblical_references, :topic
  end
end