require 'rails_helper'

RSpec.describe "Survivors", type: :request do
  describe "GET /survivors" do

    it "works! (now write some real specs)" do
      get survivors_path
      expect(response).to have_http_status(200)
    end

    it 'new one' do 
    	headers={"ACCEPT"=>"application/json"}

    	survivor_params = attributes_for(:survivor)
    	post "/survivors.json", params: {survivor: survivor_params}, headers: headers

    	expect(response.body).to include_json(
				id: /\d/,
				name: survivor_params.fetch(:name),
				age:  survivor_params.fetch(:age)
			)
    end
  end
end
