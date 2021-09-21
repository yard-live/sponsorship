class CreateSponsorshipOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :sponsorship_orders do |t|
      t.string :stripe_id
      t.string :status
      t.datetime :paid_at

      t.timestamps
    end

    add_index :sponsorship_orders, :stripe_id, unique: true
  end
end
