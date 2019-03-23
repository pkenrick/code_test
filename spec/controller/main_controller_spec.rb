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
      allow(EnqueueCallbackService).to receive(:call).and_return([])
    end

    it 'makes calls the EnqueueCallbackService with correct params' do
      expect(EnqueueCallbackService).to receive(:call)
        .with(hash_including(name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"))

      post :callback, params: { customer: {name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"} }
    end

    describe 'when errors are received from the EnqueueCallbackService' do
      before(:each) do
        allow(EnqueueCallbackService).to receive(:call).and_return(['Sample error'])
      end

      it 're-renders the "new" template' do
        expect(
          post :callback, params: { customer: {name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"} }
        ).to render_template('main/home')
      end
    end

    describe 'when no errors are received from the EnqueueCallbackService' do
      it 'redirects to the home page' do
        expect(
          post :callback, params: { customer: {name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"} }
        ).to redirect_to(root_path)
      end
    end
  end
end
