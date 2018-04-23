require 'rails_helper'

RSpec.describe InventoryItem, type: :model do
  it 'add an item to inventory' do 
  	ii = create(:inventory_item)
  	expect(ii).to be_valid
  end

  it 'cannot be create without an item' do 
  	ii = build(:inventory_item, item_id: nil)
  	expect(ii).not_to be_valid
  end

  it 'cannot be create without a quantity' do 
  	ii = build(:inventory_item, qtt: nil)
  	expect(ii).not_to be_valid
  end

  it 'survivor_already_has_item' do
  	ii = create(:inventory_item)
  	expect(InventoryItem.survivor_already_has_item ii.survivor_id, ii.item_id).to be true
  end

  it 'invalid survivor_already_has_item' do
  	survivor = create(:survivor)
  	item 		 = create(:item)
  	expect(InventoryItem.survivor_already_has_item survivor.id, item.id).to be false
  end

  it 'survivor_got_enough_quantity' do
  	ii = create(:inventory_item)
  	expect(InventoryItem.survivor_got_enough_quantity ii.survivor_id, ii.item_id, 10).to be true
  end

  it 'invalid survivor_got_enough_quantity' do
  	ii = create(:inventory_item)
  	expect(InventoryItem.survivor_got_enough_quantity ii.survivor_id, ii.item_id, 2000).to be false
  end

  it 'check_trade_issues' do 
  	s0 =  create(:survivor)
  	s1 =  create(:survivor)
  	i0 =  create(:item, point: 4)
  	i1 =  create(:item, point: 4)
  	i2 =  create(:item, point: 4)
  	i3 =  create(:item, point: 4)
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
    errors = InventoryItem.check_trade_issues trade_params[:trade_items]
  	expect((errors).length ).to eq(0)
  end

  it 'invalid check_trade_issues by not having items' do 
  	s0 =  create(:survivor)
  	s1 =  create(:survivor)
  	i0 =  create(:item)
  	i1 =  create(:item)
  	i2 =  create(:item)
  	i3 =  create(:item)
  	create(:inventory_item, survivor_id: s0.id, item_id: i0.id, qtt: 10 )
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
    errors = InventoryItem.check_trade_issues trade_params[:trade_items]
    expect((errors).length ).to be > 0
  end

  it 'invalid check_trade_issues by differ of points' do 
    s0 =  create(:survivor)
    s1 =  create(:survivor)
    i0 =  create(:item, point: 4)
    i1 =  create(:item, point: 4)
    i2 =  create(:item, point: 1)
    i3 =  create(:item, point: 1)
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
        errors = InventoryItem.check_trade_issues trade_params[:trade_items]
        expect(errors.include?((I18n.t 'controllers.inventory_items.points_differ'))).to be true
  end

  it 'trade between survivors' do
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
		InventoryItem.trade trade_params
  	expect(InventoryItem.where(survivor_id: s0.id, item_id:i0.id ).first.qtt).to eq(8)
  	expect(InventoryItem.where(survivor_id: s1.id, item_id:i0.id ).first.qtt).to eq(2)
  	expect(InventoryItem.where(survivor_id: s1.id, item_id:i2.id ).first.qtt).to eq(7)
  	expect(InventoryItem.where(survivor_id: s0.id, item_id:i2.id ).first.qtt).to eq(3)
  end

end
