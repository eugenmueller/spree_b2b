ApplicationHelper.module_eval do

  def dealer_signed_in?
    spree_current_user && spree_current_user.has_spree_role?("dealer")
  end

end
