require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe "GET home" do
    it 'returns a status of 200' do
      get :home
      expect(response).to have_http_status(200)
    end
  end

end
