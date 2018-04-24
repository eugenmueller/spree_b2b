class Spree::DealersController < Spree::StoreController
  before_action :set_spree_dealer, only: [:show, :edit, :update, :destroy]
  before_action :check_dealer_registration, except: [:registration, :update_registration]

  def registration
    @user = Spree::User.new
  end

  def update_registration
    if params[:dealer][:email] =~ Devise.email_regexp && current_order.update_attribute(:email, params[:dealer][:email])
      redirect_to spree.checkout_path
    else
      flash[:registration_error] = t(:email_is_invalid, :scope => [:errors, :messages])
      @user = Spree::Dealer.new
      render 'registration'
    end
  end

  # GET /spree/dealers
  def index
  end

  # GET /spree/dealers/1
  def show
  end

  # GET /spree/dealers/new
  def new
    @spree_dealer = Spree::Dealer.new
    @spree_dealer.user = spree_current_user
    @spree_dealer.bill_address = Spree::Address.default
    @spree_dealer.ship_address = Spree::Address.default
  end

  # GET /spree/dealers/1/edit
  def edit
  end

  # POST /spree/dealers
  def create
    @spree_dealer = Spree::Dealer.new(spree_dealer_params)
    @spree_dealer.user = spree_current_user
    if @spree_dealer.save
      redirect_to spree.dealers_path, notice: I18n.t('spree.dealer.signup_success')
    else
      flash[:error] = I18n.t('spree.dealer.signup_failed')
      render :new
    end
  end

  # PATCH/PUT /spree/dealers/1
  def update
    if @spree_dealer.update(spree_dealer_params)
      redirect_to @spree_dealer, notice: I18n.t('spree.dealer.update_success')
    else
      flash[:error] = I18n.t('spree.dealer.update_failed')
      render :edit
    end
  end

  # DELETE /spree/dealers/1
  def destroy
    @spree_dealer.destroy
    redirect_to spree_dealers_url, notice: 'Dealer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_dealer
      @spree_dealer = Spree::Dealer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_dealer_params
      params.require(:dealer).
        permit(:ship_address, :bill_address, :company, :buyer_contact,
          :manager_contact, :phone, :web_address, :taxid, :resaler_number,
          :terms, :alternate_email, :notes, :use_billing,
          user_attributes: [:email, :password, :password_confirmation],
          bill_address_attributes: permitted_address_attributes,
          ship_address_attributes: permitted_address_attributes)
    end

     # Introduces a registration step.
    def check_dealer_registration
      # Always want registration so comment out config
      #return unless Spree::Auth::Config[:registration_step]
      return if spree_current_user
      store_location
      redirect_to spree.dealer_registration_path
    end


    def permitted_address_attributes
      [:firstname, :lastname, :address1, :address2, :city, :state_id, :zipcode, :country_id, :phone]
    end
end
