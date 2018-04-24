Spree::Core::ControllerHelpers::Order.module_eval  do

  # The current incomplete order from the guest_token for use in cart and during checkout
  def current_order(options = {})
    options[:create_order_if_necessary] ||= false

    return @current_order if @current_order

    @current_order = find_order_by_token_or_user(options, true)

    if options[:create_order_if_necessary] && (@current_order.nil? || @current_order.completed?)
      @current_order = Spree::Order.new(current_order_params)
      @current_order.user ||= try_spree_current_user

      @current_order.dealer = spree_current_user.dealer? if spree_current_user
      # See issue #3346 for reasons why this line is here
      @current_order.created_by ||= try_spree_current_user
      @current_order.save!
    end

    if @current_order
      if spree_current_user
        if spree_current_user.dealer? && !@current_order.is_dealer?
          @current_order.to_dealer!
        elsif !spree_current_user.dealer? && @current_order.is_dealer?
          @current_order.to_fullsale!
        end
      end
      @current_order.last_ip_address = ip_address
      return @current_order
    end
  end

end
