class EnqueueCallbackService

  def self.call(callback_params)
    new(callback_params).call
  end

  def initialize(callback_params)
    @uri = URI("#{ENV['LEAD_API_URI']}/api/v1/create")
    @callback_params = callback_params
  end

  def call
    response = Net::HTTP.post_form(@uri, @callback_params)
    response_body = JSON.parse(response.body)
    if response_body['errors'].any?
      return { result: 'failure', errors: response_body['errors'] }
    else
      return { result: 'success', errors: [] }
    end
  rescue
    return { result: 'failure', errors: ['Callback service not current available. Please try again later.'] }
  end

end
