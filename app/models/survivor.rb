class Survivor < ApplicationRecord
	validates :name, presence: true, length: {minimum: 3}

	before_save :is_infected

	private
	
	def is_infected
		infected = infectqtt > 2
	end
end
