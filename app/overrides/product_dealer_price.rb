Deface::Override.new(
  :virtual_path => 'spree/products/_cart_form',
  :name => 'product_dealer_price',
  :insert_bottom => "[data-hook=product_price]",
  :partial => "spree/hooks/product_dealer_price",
  :disabled => false
)
