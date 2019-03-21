Rails.application.routes.draw do
  root to: 'main#home'
  post '/callback' => 'main#callback'
end
