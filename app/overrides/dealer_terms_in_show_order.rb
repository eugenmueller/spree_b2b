Deface::Override.new(virtual_path: 'spree/orders/show',
                     name: 'dealer_terms_in_show_order',
                     insert_before: "div#order[data-hook]",
                     partial: 'spree/hooks/dealer_terms_reminder')
