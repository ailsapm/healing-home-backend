class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.decimal :price_paid, precision: 8, scale: 2
      t.datetime :purchased_at
      t.string :payment_provider
      t.string :provider_transaction_id

      t.timestamps
    end
  end
end
