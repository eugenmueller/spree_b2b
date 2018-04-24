module Spree
  module DealerOrderDecorator
    def payment_required?

      #Added following for testing
      return false
      #super && !_wholesale_with_net_terms?
    end

    def is_dealer?
      dealer
    end

    def dealer
      read_attribute(:dealer) && !dealer.nil?
    end

    def dealer
      user && user.dealer
    end

    def set_line_item_prices(use_price=:price)
      line_items.includes(:variant).each do |line_item|
        line_item.price = line_item.variant.send(use_price)
        line_item.save
      end
    end

    def to_fullsale!
      self.dealer = false
      set_line_item_prices(:price)
      update!
      save
    end

    def to_dealer!
      return false unless user && user.dealer.present?
      self.dealer = true
      set_line_item_prices(:dealer_price)
      update!
      save
    end

    def add_variant(variant, quantity = 1, currency = nil)
      current_item = find_line_item_by_variant(variant)
      if current_item
        current_item.quantity += quantity
        current_item.currency = currency unless currency.nil?
        current_item.save
      else
        current_item = Spree::LineItem.new(:quantity => quantity)
        current_item.variant = variant
        if currency
          current_item.currency = currency unless currency.nil?
          current_item.price   = is_dealer? ? variant.dealer_price : variant.price_in(currency).amount
        else
          current_item.price   = is_dealer? ? variant.dealer_price : variant.price
        end
        self.line_items << current_item
      end

      self.reload
      current_item
    end

    private

    def _dealer_with_net_terms?
      is_dealer? && dealer.terms != 'Credit Card'
    end
  end

  Order.class_eval do
    prepend DealerOrderDecorator
  end

end
