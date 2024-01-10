require 'rails_helper'

RSpec.describe 'Senator Search' do
  describe 'happy path' do
    
    it 'allows user to search for Senators by last name' do
      json_response = File.read('spec/fixtures/members_of_the_senate.json')
      stub_request(:get, "https://api.propublica.org/congress/v1/116/senate/members.json").
        to_return(status: 200, body: json_response)
      visit root_path

      fill_in :search, with: 'Sanders'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(page).to have_content("Senator Bernard Sanders was found!")
      expect(page).to have_content("SenSanders")
    end
  end
end