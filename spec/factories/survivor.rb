FactoryBot.define do 
	factory :survivor do 
		name Faker::Name.name
		age (Random.new).rand(76)
		gender (Random.new).rand(3)
	end

	factory :SurvivorWithItem do 
		name Faker::Name.name
		age (Random.new).rand(76)
		gender (Random.new).rand(3)
		inventory_item_attributes {item_id 1}
	end

	factory :survivor_with_item do 
		name Faker::Name.name
		age (Random.new).rand(76)
		gender (Random.new).rand(3)
		inventory_item_attributes {item_id 1}
	end

end