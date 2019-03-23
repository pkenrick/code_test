require 'rails_helper'

RSpec.describe EnqueueCallbackService, type: :service do

  describe '#call' do
    let(:valid_params) { {name: "Test Name", business_name: "Test Business Name", email: "test@example.com", telephone_number: "01234567891"} }

    before(:each) do
      stub_request(:post, "http://mic-leads.dev-test.makeiteasy.com/api/v1/create").to_return(status: 200, body: '{"message":"This is a stubbed response", "errors":["Sample error"]}', headers: {})
    end

    it 'should make a request to the api with the correct params' do
      uri = URI("http://mic-leads.dev-test.makeiteasy.com/api/v1/create")
      expect(Net::HTTP).to receive(:post_form).with(uri, hash_including(name: "Test Name")).and_call_original
      EnqueueCallbackService.call(valid_params)
    end

    describe 'when errors received from API' do
      it 'should return a hash containing a successful result and no errors' do
        expect(EnqueueCallbackService.call(valid_params)).to eq(['Sample error'])
      end
    end

    describe 'when no errors are received from API' do
      it 'should return a hash containing a failed result and any errors' do
        stub_request(:post, "http://mic-leads.dev-test.makeiteasy.com/api/v1/create").to_return(status: 200, body: '{"message":"This is a stubbed response", "errors":[]}', headers: {})
        expect(EnqueueCallbackService.call(valid_params)).to eq([])
      end
    end
  end

end
