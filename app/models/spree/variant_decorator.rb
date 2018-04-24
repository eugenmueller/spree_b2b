Spree::PermittedAttributes.variant_attributes << :dealer_price

Spree::Variant.class_eval do
  scope :dealer, ->{where("spree_variants.dealer_price > 0")}

  def is_dealerable?
    0 < dealer_price
  end

end
