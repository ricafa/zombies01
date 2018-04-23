FactoryBot.define do 
	factory :survivor do 
		name Faker::Name.name
		age (Random.new).rand(76)
		gender (Random.new).rand(3)
	end
end