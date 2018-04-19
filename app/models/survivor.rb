class Survivor < ApplicationRecord
	has_many :inventory_items
	accepts_nested_attributes_for :inventory_items

	validates :name, presence: true, length: {minimum: 3}

	def mark_contamination_report
		self.infectqtt =0 if self.infectqtt.nil? 
		self.infectqtt = self.infectqtt+1
		verify_contamination
		save
		self.infected
	end

	def verify_contamination
		self.infected = self.infectqtt > 2
	end
end
