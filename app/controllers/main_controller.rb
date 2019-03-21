class MainController < ApplicationController

  def home
  end

  def callback
    uri = URI("#{ENV['LEAD_API_URI']}/api/v1/create")
    res = Net::HTTP.post_form(uri, callback_params)
  end

  private

  def callback_params
    {
      access_token: ENV['SECRET_KEY_BASE'],
      pGUID: ENV['LEAD_API_PGUID'],
      pAccName: ENV['LEAD_API_PACCNAME'],
      pPartner: ENV['LEAD_API_PPARTNER'],
      name: params[:name],
      business_name: params[:business_name],
      email: params[:email],
      telephone_number: params[:telephone_number]
    }
  end
end
