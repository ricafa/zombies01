require 'rails_helper'

RSpec.describe Survivor, type: :model do
  it 'Creates a Survivor' do 
  	survivor = create(:survivor)
  	expect(survivor).to be_valid
  end

  it 'cannot be created with invalid name' do 
  	expect(build(:survivor, name:'')).to_not be_valid
  end 

  it 'mark_contamination_report' do
    survivor = create(:survivor)
    expect(survivor.mark_contamination_report).to be false
    expect(survivor.infectqtt).to eq(1)
    expect(survivor.infected).to be false
  end

  it 'is infected' do 
  	survivor = create(:survivor)
    3.times{ survivor.mark_contamination_report }
  	expect(survivor.infectqtt).to be == 3
  	expect(survivor.infected).to be true
  end
end
