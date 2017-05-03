require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name with less than three characters' do
    restaurant = Restaurant.new(name: 'ky')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Squid Shack')
    restaurant = Restaurant.new(name: 'Squid Shack')
    expect(restaurant).to have(1).error_on(:name)
  end

end
