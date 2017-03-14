class CreateMinusTransactions < ActiveRecord::Migration
  def change
    create_table :minus_transactions do |t|
      t.belongs_to :user, :index => true
      t.integer :amount
      t.string  :title
      t.string  :category

      t.timestamps
    end
  end
end