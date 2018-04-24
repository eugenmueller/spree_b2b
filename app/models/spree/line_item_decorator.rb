module SpreeB2b
  module LineItemDecorator
    def copy_price
      if variant
        self.price = (order.is_dealer? && variant.is_dealerable? ? variant.dealer_price : variant.price)
        self.cost_price = variant.cost_price if cost_price.nil?
        self.currency = variant.currency if currency.nil?
      end
    end
  end
end

Spree::LineItem.class_eval do
  prepend SpreeB2b::LineItemDecorator

  delegate :dealer_price, :is_dealerable?, to: :variant
end
