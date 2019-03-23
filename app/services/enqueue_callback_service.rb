class EnqueueCallbackService

  def self.call(customer_params)
    new(customer_params).call
  end

  def initialize(customer_params)
    @uri = URI("#{ENV['LEAD_API_URI']}/api/v1/create")
    @callback_params = non_customer_params.merge(customer_params)
  end

  def call
    response = Net::HTTP.post_form(@uri, @callback_params)
    response_body = JSON.parse(response.body)
    if response_body['errors'].any?
      return  response_body['errors']
    else
      return []
    end
  # rescue
  #   return ['Callback service not current available. Please try again later.']
  end

  def non_customer_params
    {
      access_token: ENV['LEAD_API_ACCESS_TOKEN'],
      pGUID: ENV['LEAD_API_PGUID'],
      pAccName: ENV['LEAD_API_PACCNAME'],
      pPartner: ENV['LEAD_API_PPARTNER'],
    }
  end

end
