require 'rails_helper'

RSpec.describe 'Callback', type: :feature do

  describe 'User visits the homepage' do
    before(:each) do
      visit '/'
    end

    it 'displays the request callback form' do
      expect(page).to have_content('Welcome to Widgets Are Us')
    end

    describe 'when submitting valid customer details' do
      before(:each) do
        stub_request(:post, "http://mic-leads.dev-test.makeiteasy.com/api/v1/create")
        .to_return(status: 200, body: '{"message":"This is a stubbed response", "errors":[]}', headers: {})

        fill_in('customer_name', with: 'John Smith')
        fill_in('customer_business_name', with: 'Widget Customer Ltd')
        fill_in('customer_email', with: 'john.smith@example.com')
        fill_in('customer_telephone_number', with: '01234567891')
        click_button('Submit')
      end

      it 'displays a message thanking the user' do
        expect(page).to have_content("Thanks! A member of our team will call you back shortly.")
      end
    end

    describe 'when submitting invalid customer details' do
      before(:each) do
        stub_request(:post, "http://mic-leads.dev-test.makeiteasy.com/api/v1/create")
        .to_return(status: 200, body: '{"message":"This is a stubbed response", "errors":["You must submit a telephone number"]}', headers: {})

        fill_in('customer_name', with: 'John Smith')
        fill_in('customer_business_name', with: 'Widget Customer Ltd')
        fill_in('customer_email', with: 'john.smith@example.com')
        click_button('Submit')
      end

      it 'displays a error message describing the error that has occured' do
        expect(page).to have_content("You must submit a telephone number")
      end
    end
  end

end
