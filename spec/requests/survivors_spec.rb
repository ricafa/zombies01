require 'rails_helper'

RSpec.describe "Survivors", type: :request do
  describe "GET /survivors" do

    it "works!" do
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

    it 'creates new one, with inventory' do
      headers={"ACCEPT"=>"application/json"}
      item = create(:item)
      item2 = create(:item)
      survivor_params = {name: 'Ricardo', inventory_items_attributes:[{item_id: item.id, qtt: 2}, {item_id: item2.id, qtt: 3}]}
      post "/survivors.json", params: {survivor: survivor_params}, headers: headers

      p response.body
      expect(response.body).to include_json(
        name: (  be_kind_of String)
      )
    end

    it 'report contamination' do 
    	survivor = create(:survivor)
    	get "/contaminated/#{survivor.id}"

    	expect(response.body).to include_json(
				msg: (I18n.t 'controllers.survivor.success_report_message')
			)
    end

    it 'mark as infected' do 
    	survivor = create(:survivor)
    	3.times{get "/contaminated/#{survivor.id}"}

    	expect(response.body).to include_json(
				msg: (I18n.t 'controllers.survivor.infected_message')
			)
    end

    it 'update itself location' do 
      headers={"ACCEPT"=>"application/json"}
      survivor = create(:survivor)
      coordinate = rand*120
      patch "/survivors/#{survivor.id}", params: {survivor: {latitude: coordinate, longitude: coordinate}}, headers: headers
      expect(response.body).to include_json(
        latitude: (  be_kind_of String),
        longitude: ( be_kind_of String)
      )
    end
  end
end
