# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Survivor.count == 0
	5.times{|i| Survivor.create(name: 'Survivor #{i}', age: i*13)}
	puts "Survivors ready for the zombies"
else
	puts "Survivors already there"
end

if Item.count == 0	
	Item.create(description: "Water", point: 4)
	Item.create(description: "Food", point: 3)
	Item.create(description: "Medication", point: 2)
	Item.create(description: "Ammunition", point: 1)
	puts "Items created"
else
	puts "Items already created"
end

if InventoryItem.count == 0
	Survivor.all.each do |s|
		3.times do |i|
			InventoryItem.create(survivor_id: s.id ,item_id: Item.take(1).first.id, qtt: 10)
		end
	end
	puts "Inventory created successfully."
else 
	puts "Inventory already created."
end