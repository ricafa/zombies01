require 'rails_helper'

RSpec.describe "InventoryItems", type: :request do
  describe "GET /inventory_items" do
    it "get 200 OK! " do
      get inventory_items_path
      expect(response).to have_http_status(200)
    end

    it 'trade between survivors success' do
    	headers={"ACCEPT"=>"application/json"}
    	s0 =  create(:survivor)
	  	s1 =  create(:survivor)
	  	i0 =  create(:item)
	  	i1 =  create(:item)
	  	i2 =  create(:item)
	  	i3 =  create(:item)
	  	create(:inventory_item, survivor_id: s0.id, item_id: i0.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s0.id, item_id: i1.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s1.id, item_id: i2.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s1.id, item_id: i3.id, qtt: 10 )
	  	trade_params = {
	  									trade_items: [{
	  										survivor_id: s0.id,
	  										items: 
													[ 
														{item: i0.id, qtt: 2}, 
														{item: i1.id, qtt: 2} 
													]
		  									},
		  									{
	  										survivor_id: s1.id,
	  										items:  [ 
														{item: i2.id, qtt: 3},
														{item: i3.id, qtt: 3} 
													] 
												}]
	  								}.to_h
    	post "/trade", params: {trade_items: trade_params }, headers: headers
      expect(response.body).to include_json(
        done: true,
        msg: (I18n.t 'controllers.inventory_items.trade_success')
      )
    end

    it 'trade between survivors without params' do
    	headers={"ACCEPT"=>"application/json"}
    	s0 =  create(:survivor)
	  	s1 =  create(:survivor)
	  	i0 =  create(:item)
	  	i1 =  create(:item)
	  	i2 =  create(:item)
	  	i3 =  create(:item)
	  	create(:inventory_item, survivor_id: s0.id, item_id: i0.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s0.id, item_id: i1.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s1.id, item_id: i2.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s1.id, item_id: i3.id, qtt: 10 )
	  	trade_params = {
	  									another: [{
	  										survivor_id: s0.id,
	  										items: 
													[ 
														{item: i0.id, qtt: 2}, 
														{item: i1.id, qtt: 2} 
													]
		  									},
		  									{
	  										survivor_id: s1.id,
	  										items:  [ 
														{item: i2.id, qtt: 3},
														{item: i3.id, qtt: 3} 
													] 
												}]
	  								}.to_h
    	post "/trade", params: {trade_items: trade_params }, headers: headers
      expect(response.body).to include_json(
        done: false,
        msg: (I18n.t 'controllers.inventory_items.empty_params')
      )
    end

    it 'trade between survivors missing params' do
    	headers={"ACCEPT"=>"application/json"}
    	s0 =  create(:survivor)
	  	s1 =  create(:survivor)
	  	i0 =  create(:item)
	  	i1 =  create(:item)
	  	i2 =  create(:item)
	  	i3 =  create(:item)
	  	create(:inventory_item, survivor_id: s0.id, item_id: i0.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s0.id, item_id: i1.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s1.id, item_id: i2.id, qtt: 10 )
	  	create(:inventory_item, survivor_id: s1.id, item_id: i3.id, qtt: 10 )
	  	trade_params = {
	  									trade_items: [{
	  										survivor_id: s0.id,
	  										items: 
													[ 
														{item: i0.id, qtt: 2}, 
														{item: i1.id, qtt: 2} 
													]
		  									}]
	  								}.to_h
    	post "/trade", params: {trade_items: trade_params }, headers: headers
      expect(response.body).to include_json(
        done: false,
        msg: (I18n.t 'controllers.inventory_items.missing_params')
      )
    end

  end
end
