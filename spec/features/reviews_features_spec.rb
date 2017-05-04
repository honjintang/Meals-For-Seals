require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Avocado in Paradise', description: "Lovely", user: User.new}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Avocado in Paradise'
    fill_in "Thoughts", with: "AMAZIIIIIING"
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    click_link 'All reviews'
    expect(page).to have_content 'AMAZIIIIIING'
  end
end
