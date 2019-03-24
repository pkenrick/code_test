class MainController < ApplicationController

  def home
    @customer = Customer.new
  end

  def callback
    redirect_to root_path and return if request.get?

    errors = EnqueueCallbackService.call(customer_params)

    if errors.empty?
      flash[:success] = "Thanks!  A member of our team will call you back shortly."
      redirect_to root_path
    else
      flash.now[:danger] = "Sorry, the following errors occurred: <br/><br/>#{create_error_list(errors)}".html_safe
      @customer = Customer.new(customer_params)
      render :home
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :business_name, :email, :telephone_number)
  end

  def create_error_list(errors)
    error_message = "<ul>"
    errors.each do |error|
      error_message += "<li>#{error}</li>"
    end
    error_message += "</ul>"
  end
end
