#insert_before :account_my_orders,         'hooks/wholesale_customer'
Deface::Override.new(:virtual_path => 'spree/users/show',
:name => 'dealer_title',
:replace => "h1.h2",
:partial => "spree/hooks/dealer_title",
:disabled => false)
