require "rails_helper"

RSpec.describe CallsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/calls").to route_to("calls#index")
    end

    it "routes to #new" do
      expect(get: "/calls/new").to route_to("calls#new")
    end

    it "routes to #show" do
      expect(get: "/calls/1").to route_to("calls#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/calls/1/edit").to route_to("calls#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/calls").to route_to("calls#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/calls/1").to route_to("calls#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/calls/1").to route_to("calls#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/calls/1").to route_to("calls#destroy", id: "1")
    end
  end
end
