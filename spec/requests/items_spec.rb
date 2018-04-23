require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /items" do
    it "listing all items" do
      create(:item)
      create(:item)
      get items_path
      expect(response).to have_http_status(200)
    end

    it 'list one item' do
      item = create(:item)
      get "/items/#{item.id}"

      expect(response.body).to include_json(
        description: item.description
        )

    end
  end
end
