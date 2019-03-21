require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe "GET home" do
    it 'returns a status of 200' do
      get :home
      expect(response).to have_http_status(200)
    end
  end

  describe "POST callback" do
    before(:each) do
      stub_request(:post, "http://mic-leads.dev-test.makeiteasy.com/api/v1/create").to_return(status: 200, body: "This is a stubbed response", headers: {})
    end

    it 'makes a request to the test api with correct params' do
      uri = URI("http://mic-leads.dev-test.makeiteasy.com/api/v1/create")
      expect(Net::HTTP).to receive(:post_form)
        .with(uri, hash_including(name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"))
        .and_call_original

      post :callback, params: {name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"}

    end
  end

end
