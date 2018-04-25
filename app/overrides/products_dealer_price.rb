Deface::Override.new(
  virtual_path: 'spree/products/_product',
  name: 'products_dealer_price',
  replace: '[data-hook=products_list_item]',
  partial: 'spree/hooks/products_dealer_price',
  disabled: false
)
