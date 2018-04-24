class Spree::Admin::DealersController < Spree::Admin::ResourceController
  before_action :approval_setup, only: [:approve, :reject]
  before_action :set_spree_dealer, only: [:show, :edit, :update, :destroy]

  def index
    @spree_dealers = collection
  end

  def show
  end

  def new
    @spree_dealer = Spree::Dealer.new
    @spree_dealer.build_user
    @spree_dealer.bill_address = Spree::Address.default
    @spree_dealer.ship_address = Spree::Address.default
  end

  def create
    @spree_dealer = Spree::Dealer.new(spree_dealer_params)

    if @spree_dealer.save
      redirect_to spree.admin_dealers_path, notice: I18n.t('spree.admin.dealer.success')
    else
      flash[:error] = I18n.t('spree.admin.dealer.failed')
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @spree_dealer.update_attributes(spree_dealer_params)
      redirect_to spree.edit_admin_dealer_path(@spree_dealer), notice: I18n.t('spree.admin.dealer.update_success')
    else
      flash[:error] = I18n.t('spree.admin.dealer.update_failed')
    end
  end

  def destroy
    if @spree_dealer.destroy
      redirect_to collection_url, success: I18n.t('spree.admin.dealer.destroy_success')
    end
  end

  def approve
    return redirect_to request.referer, flash: { error: "Dealer is already active." } if @spree_dealer.active?
    @spree_dealer.activate!
    redirect_to request.referer, flash: { notice: "Dealer was successfully approved." }
  end

  def reject
    return redirect_to request.referer, flash: { error: "Dealer is already rejected." } unless @spree_dealer.active?
    @spree_dealer.deactivate!
    redirect_to request.referer, flash: { notice: "Dealer was successfully rejected." }
  end

  private

  def approval_setup
    set_spree_dealer
    @role = Spree::Role.where(name: 'dealer').first_or_create
  end

  def set_spree_dealer
    @spree_dealer = Spree::Dealer.find(params[:id])
  end

  def spree_dealer_params
    params.require(:dealer).
      permit(:ship_address, :bill_address, :company, :buyer_contact,
        :manager_contact, :phone, :web_address, :taxid, :resaler_number,
        :terms, :alternate_email, :notes, :use_billing,
        user_attributes: [:email, :password, :password_confirmation],
        bill_address_attributes: permitted_address_attributes,
        ship_address_attributes: permitted_address_attributes)
  end

  def collection
    return @collection if @collection.present?

    params[:search] ||= {}
    params[:search][:meta_sort] ||= "company.asc"
    @search = Spree::Dealer.ransack(params[:q])
    @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end
end
