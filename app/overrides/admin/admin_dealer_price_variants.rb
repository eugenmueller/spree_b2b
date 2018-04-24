Deface::Override.new( :virtual_path => 'spree/admin/variants/_form',
                      :name => 'admin_dealer_price_variants',
                      :insert_before => "[data-hook='cost_price']",
                      :partial => "spree/admin/hooks/variant_form",
                      :disabled => false)
