Spree::Core::Engine.add_routes do
  # Add your extension routes here

  get '/dealers/registration' => 'dealers#registration', :as => :dealer_registration
  put '/dealers/registration' => 'dealers#update_registration', :as => :update_dealer_registration

  resources :dealers

  namespace(:admin) do
    resources :dealers do
      member do
        get :approve
        get :reject
      end
    end

    resources :dealer_configurations
  end
end
