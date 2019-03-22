class MainController < ApplicationController

  def callback
    response = EnqueueCallbackService.call(callback_params)

    if response[:result] == 'success'
      flash[:success] = "Thanks!  A member of our team will call you back shortly."
      redirect_to root_path
    else
      flash.now[:danger] = "Sorry, the following errors occurred: <br/><br/>#{create_error_list(response[:errors])}".html_safe
      @name = params[:name]
      @business_name = params[:business_name]
      @email = params[:email]
      @telephone_number = params[:telephone_number]
      render :home
    end
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

  def create_error_list(errors)
    error_message = "<ul>"
    errors.each do |error|
      error_message += "<li>#{error}</li>"
    end
    error_message += "</ul>"
  end
end
