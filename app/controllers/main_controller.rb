class MainController < ApplicationController

  def callback
    uri = URI("#{ENV['LEAD_API_URI']}/api/v1/create")
    response = Net::HTTP.post_form(uri, callback_params)

    response_body = JSON.parse(response.body)
    if response_body['errors'].any?
      flash.now[:danger] = craft_error_message(response_body).html_safe
      render :home
    else
      flash[:success] = "Thanks!  A member of our team will call you back shortly."
      redirect_to root_path
    end

  rescue
    flash[:danger] = "Sorry, there was a problem saving your details.  Please try again later."
    redirect_to root_path
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

  def craft_error_message(response_body)
      error_message = "Sorry, your information contained the following errors:<br/><br/><ul>"
      response_body['errors'].each do |error|
        error_message += "<li>#{error}</li>"
      end
      error_message += "</ul>"
  end
end
