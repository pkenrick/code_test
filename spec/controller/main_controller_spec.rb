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
      allow(EnqueueCallbackService).to receive(:call).and_return({ result: 'success', errors: [] })
    end

    it 'makes calls the EnqueueCallbackService with correct params' do
      expect(EnqueueCallbackService).to receive(:call)
        .with(hash_including(name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"))

      post :callback, params: {name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"}
    end
  end

end
