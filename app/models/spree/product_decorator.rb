Spree::PermittedAttributes.product_attributes << :dealer_price

Spree::Product.instance_eval do
  delegate :dealer_price, :dealer_price=, to: :master if Spree::Variant.table_exists? && Spree::Variant.column_names.include?("dealer_price")
end

Spree::Product.class_eval do

  def is_dealerable?
    0.01 < master.dealer_price
  end

  def self.dealerable
    dealer_products = []
    all.each do |p|
      dealer_products << p if p.is_dealerable?
    end
    dealer_products
  end

end
