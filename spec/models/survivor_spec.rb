require 'rails_helper'

RSpec.describe Survivor, type: :model do
  it 'Creates a Survivor' do 
  	survivor = create(:survivor)
  	expect(survivor).to be_valid
  end

  it 'cannot be created with invalid name' do 
  	expect(build(:survivor, name:'')).to_not be_valid
  end 

  it 'is infected' do 
  	survivor = create(:survivor)
  	survivor.infectqtt += 1
  	survivor.save!
  	survivor.infectqtt += 1
  	survivor.save!
  	survivor.infectqtt += 1
  	survivor.save!
  	expect(survivor.infectqtt).to be == 3
  	expect(survivor.infected).to be true
  end
end
