class InventoryItem < ApplicationRecord
  belongs_to :survivor, required: false
  belongs_to :item

  validates_presence_of :item_id, :qtt

  def self.survivor_already_has_item survivor, item
  	InventoryItem.where("survivor_id = ? and item_id = ?", survivor, item).exists?
  end

  def self.survivor_got_enough_quantity survivor, item, qtt
		InventoryItem.where("survivor_id = ? and item_id = ? and qtt >= ?", 
  		survivor, item, qtt).count > 0
  end

  def self.check_trade_issues trade_items
  	errors = [];
  	2.times do |t|
			trade_items[t][:items].each do |i|
				survivor = trade_items[t][:survivor_id]
				item = i[:item]
				qtt  = i[:qtt]
				unless survivor_got_enough_quantity survivor, item, qtt
					errors << "#{Survivor.find(survivor).name}(#{survivor}), don't get quantity #{qtt} of #{Item.find(item).description}(#{item})"
				end
			end
		end
		errors
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
					if survivor_already_has_item survivor, item
						InventoryItem.where("survivor_id = ? and item_id = ? ", receiver, item ).update_all("qtt = qtt + #{qtt}")
					else
						InventoryItem.create(survivor_id: receiver, item_id: item, qtt: qtt)
					end
				end
			end
			return {done: true}
		else
			return {done: false, errors: errors}
		end
  end

end
