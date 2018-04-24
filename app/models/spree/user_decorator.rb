Spree::User.class_eval do
  has_one :dealer, :class_name => "Spree::Dealer"

  scope :dealer, -> { includes(:spree_roles).where("spree_roles.name" => "dealer") }

  def dealer?
    has_spree_role?("dealer") && !dealer.nil?
  end

end
