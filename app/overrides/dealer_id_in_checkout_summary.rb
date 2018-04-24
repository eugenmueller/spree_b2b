Deface::Override.new( :virtual_path => 'spree/checkout/_summary',
                      :name => 'dealer_id_in_checkout_summary',
                      :insert_before => "[data-hook='order_summary']",
                      :partial =>  'spree/hooks/dealer_customer_id',
                      :disabled => false)
