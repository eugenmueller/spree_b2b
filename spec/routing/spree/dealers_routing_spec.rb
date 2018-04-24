require "rails_helper"

RSpec.describe Spree::DealersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/spree/dealers").to route_to("spree/dealers#index")
    end

    it "routes to #new" do
      expect(:get => "/spree/dealers/new").to route_to("spree/dealers#new")
    end

    it "routes to #show" do
      expect(:get => "/spree/dealers/1").to route_to("spree/dealers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/spree/dealers/1/edit").to route_to("spree/dealers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/spree/dealers").to route_to("spree/dealers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/spree/dealers/1").to route_to("spree/dealers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/spree/dealers/1").to route_to("spree/dealers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/spree/dealers/1").to route_to("spree/dealers#destroy", :id => "1")
    end

  end
end
