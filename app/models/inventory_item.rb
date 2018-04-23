class InventoryItem < ApplicationRecord
  belongs_to :survivor, required: false
  belongs_to :item

  validates_presence_of :item_id, :qtt

  before_update :clean_inventories

  def self.survivor_already_has_item survivor, item
  	InventoryItem.where("survivor_id = ? and item_id = ?", survivor, item).exists?
  end

  def self.survivor_got_enough_quantity survivor, item, qtt
		InventoryItem.where("survivor_id = ? and item_id = ? and qtt >= ?", 
  		survivor, item, qtt).count > 0
  end

  def self.check_trade_issues trade_items
  	points = {0=>0, 1=>0}
  	errors = [];
  	2.times do |t|
			trade_items[t][:items].each do |i|
				survivor = trade_items[t][:survivor_id]
				item = i[:item]
				qtt  = i[:qtt]
				unless survivor_got_enough_quantity survivor, item, qtt
					errors << (I18n.t 'controllers.inventory_items.items_enough',
							sur_name: Survivor.find(survivor).name,
							sur_id: survivor,
							qtt: qtt,
							item_id: item,
							item_description: Item.find(item).description)
					#{}"#{Survivor.find(survivor).name}(#{survivor}), don't get quantity #{qtt} of #{Item.find(item).description}(#{item})"
				end
				points[t] = points[t] + Item.find(item).point
			end
		end
		errors << (I18n.t 'controllers.inventory_items.points_differ') if points[0] != points[1]  
		errors
  end

  def self.trade_items
  	  	return {
  									trade_items: [{
  										survivor_id: 2,
  										items: 
												[ 
													{item: 2, qtt: 2}, 
													{item: 3, qtt: 2} 
												]
	  									},
	  									{
  										survivor_id: 3,
  										items:  [ 
													{item: 4, qtt: 3},
													{item: 1, qtt: 3} 
												] 
											}]
  								}
  end

  def self.trade trade_params
  	errors = self.check_trade_issues trade_params[:trade_items]
  	if errors.length == 0
	  	survivor01   = trade_params[:trade_items][0]
	  	survivor02 = trade_params[:trade_items][1]
	  	2.times do |t|
	  		if t == 0
					own = survivor01[:survivor_id].to_i
			  	receiver = survivor02[:survivor_id].to_i
			  else
			  	own = survivor02[:survivor_id].to_i
			  	receiver = survivor01[:survivor_id].to_i
			  end
				trade_params[:trade_items][t][:items].each do |i|
					item = i[:item]
					qtt = i[:qtt]
					InventoryItem.where("survivor_id = ? and item_id = ? and qtt >= ?", own, item, qtt )
						.update_all("qtt = qtt - #{qtt}")

					#verify if item exists in survivor inventory.
					if survivor_already_has_item receiver, item
						InventoryItem.where("survivor_id = ? and item_id = ? ", receiver, item ).update_all("qtt = qtt + #{qtt}")
					else
						InventoryItem.create(survivor_id: receiver, item_id: item, qtt: qtt)
					end
				end
			end
			return {done: true, msg: (I18n.t 'controllers.inventory_items.trade_success')}
		else
			return {done: false, errors: errors}
		end
  end

private

	def clean_inventories
		#could be a job, scheduled to run once per day
		InventoryItem.where('qtt <= 0').destroy_all
	end
end
