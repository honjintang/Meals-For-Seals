require 'rails_helper'

describe User, type: :model do
  it 'has many restaurants' do
    should have_many(:restaurants)
  end
end
