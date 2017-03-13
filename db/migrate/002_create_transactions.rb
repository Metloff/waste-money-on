class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user, :index => true
      t.string  :sign
      t.integer :amount
      t.string  :title
      t.string  :category

      t.timestamps
    end
  end
end