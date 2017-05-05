require 'rails_helper'

feature 'reviewing' do

  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'seal@seal.com'
    fill_in 'Password', with: 'kissfromarose'
    fill_in 'Password confirmation', with: 'kissfromarose'
    click_button 'Sign up'
  end
  
  before { Restaurant.create name: 'Avocado in Paradise', description: "Lovely", user: User.new, id:1}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Avocado in Paradise'
    fill_in "Thoughts", with: "AMAZIIIIIING"
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    click_link 'All reviews'
    expect(current_path).to eq '/restaurants/1'
    expect(page).to have_content 'AMAZIIIIIING'
  end
end
