require 'rails_helper'

RSpec.describe "InventoryItems", type: :request do
  describe "GET /inventory_items" do
    it "get 200 OK! " do
      get inventory_items_path
      expect(response).to have_http_status(200)
    end
  end
end
