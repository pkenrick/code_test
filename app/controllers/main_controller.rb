class MainController < ApplicationController

  def home
  end

  def callback
    uri = URI('http://mic-leads.dev-test.makeiteasy.com/api/v1/create')
    params = {}
    res = Net::HTTP.post_form(uri, params)
    puts "============ #{res.body}"
  end
end
