require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name with less than three characters' do
    restaurant = Restaurant.new(name: 'S')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end
