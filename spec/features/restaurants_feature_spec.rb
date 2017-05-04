require 'rails_helper'

feature 'restaurants' do

  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'seal@seal.seal'
    fill_in 'Password', with: 'kissfromarose'
    fill_in 'Password confirmation', with: 'kissfromarose'
    click_button 'Sign up'
  end


  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Avocado in Paradise')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Avocado in Paradise'
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Avocado in Paradise'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Avocado in Paradise'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let!(:avocado_in_paradise){ Restaurant.create(name:'Avocado in Paradise') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Show Avocado in Paradise'
      expect(page).to have_content 'Avocado in Paradise'
      expect(current_path).to eq "/restaurants/#{avocado_in_paradise.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'Avocado in Paradise', description: 'Where avocados meet their makers', id: 1 }
    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Avocado in Paradise'
      fill_in 'Name', with: "Avolicious"
      fill_in 'Description', with: "Only the perfectly ripe"
      click_button 'Update Restaurant'
      click_link 'Show Avolicious'
      expect(page).to have_content "Avolicious"
      expect(page).to have_content "Only the perfectly ripe"
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'Avocado in Paradise', description: 'Where avocados meet their makers' }

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Avocado in Paradise'
      expect(page).not_to have_content 'Avocado in Paradise'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'ky'
      click_button 'Create Restaurant'
      expect(page).not_to have_content 'ky'
      expect(page).to have_content 'error'
    end
  end

  context 'user is not logged in' do
    scenario 'cannot add restaurant' do
      click_link 'Sign out'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
