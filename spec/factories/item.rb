FactoryBot.define do 
	factory :item do 
		description ['Water', 'Food','Medication','Ammunition'].sample
		point (1..4).to_a.sample
	end
end