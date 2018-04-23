require 'item.rb'
require 'survivor.rb'

FactoryBot.define do 
	factory :inventory_item do 
		item_id {(create(:item)).id}
		survivor_id {(create(:survivor)).id}
		qtt 10
	end
end