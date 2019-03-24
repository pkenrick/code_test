Rails.application.routes.draw do
  root to: 'main#home'
  match '/callback' => 'main#callback', via: [:get, :post]
end
