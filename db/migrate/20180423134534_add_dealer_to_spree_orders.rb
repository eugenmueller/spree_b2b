class AddDealerToSpreeOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :dealer, :boolean, default: false
  end
end
