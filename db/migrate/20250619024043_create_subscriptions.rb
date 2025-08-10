class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.datetime :started_at
      t.datetime :expires_at
      t.string :payment_provider
      t.string :provider_subscription_id

      t.timestamps
    end
  end
end
