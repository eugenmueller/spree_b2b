class CreateSpreeDealers < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_dealers do |t|
      t.references :spree_user, foreign_key: true
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string :company
      t.string :buyer_contact
      t.string :manager_contact
      t.string :phone
      t.string :fax
      t.string :resale_number
      t.string :taxid
      t.string :web_address
      t.string :terms
      t.string :alternate_email
      t.text :notes

      t.timestamps
    end
    add_index :spree_dealers, [:billing_address_id, :shipping_address_id], name: 'dealers_addresses'
  end
end
