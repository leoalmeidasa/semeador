class AddTitheFieldsToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :is_tithe, :boolean, default: false
    add_column :transactions, :tithe_percentage, :decimal, precision: 5, scale: 2
    add_column :transactions, :church_name, :string
    add_column :transactions, :offering_type, :string
    add_column :transactions, :notes, :text
  end
end