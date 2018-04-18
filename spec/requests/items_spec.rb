require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /items" do
    it "works! (now write some real specs)" do
      get items_path
      expect(response).to have_http_status(200)
    end

    it "get json" do 
      item = create(:item)
      expect(Item.count).to eq(1)
    	get items_path
      expect(response.body).to include_json([
    		description: (be_kind_of String),
    		point: /\d/
    	])
    end
  end
end
