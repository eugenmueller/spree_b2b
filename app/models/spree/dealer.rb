class Spree::Dealer < ApplicationRecord
  belongs_to :user, class_name: 'Spree::User', foreign_key: 'spree_user_id'

  belongs_to :bill_address, foreign_key: 'billing_address_id',
                            class_name: 'Spree::Address',
                            dependent: :destroy
  belongs_to :ship_address, foreign_key: 'shipping_address_id',
                            class_name: 'Spree::Address',
                            dependent: :destroy

  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  accepts_nested_attributes_for :user

  attr_accessor :use_billing
  before_validation :clone_billing_address, if: '@use_billing'
  validates :company, :buyer_contact, :manager_contact, presence: true

  delegate :spree_roles, :email, to: :user

  alias_attribute :user_id, :spree_user_id

  def activate!
    get_dealer_role
    return false if user.spree_roles.include?(@role)
    user.spree_roles << @role
    #WholesaleMailer.approve_wholesaler_email(self).deliver
    user.save
  end

  def deactivate!
    get_dealer_role
    return false unless user.spree_roles.include?(@role)
    user.spree_roles.delete(@role)
    user.save
  end

  def active?
    user && user.has_spree_role?("dealer")
  end

  def self.term_options
    ["Credit Card", "Net 30"]
  end

  # Added for address form functionality
  def shipping_eq_billing_address?
    (bill_address.empty? && ship_address.empty?) || bill_address.same_as?(ship_address)
  end

  private

  def get_dealer_role
    @role = Spree::Role.where(name: 'dealer').first_or_create
  end

  def clone_billing_address
    if self.bill_address && self.ship_address.nil?
      self.ship_address = self.bill_address.clone
    # else
    #   self.ship_address.attributes = self.bill_address.attributes.except("id", "updated_at", "created_at")
    end
    true
  end

end
