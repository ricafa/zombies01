require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'creates an item' do 
  	expect(create(:item)).to be_valid
  end
end
