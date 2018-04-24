Deface::Override.new( :virtual_path => 'spree/shared/_store_menu',
                      :name => 'dealer_in_store_menu',
                      :insert_after => "li#link-to-login[data-hook]",
                      :text => %q{<li><%= link_to Spree.t(:dealers) , spree.dealers_path %></li>},
                      :disabled => false)
