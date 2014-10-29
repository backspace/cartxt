Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/admin'
  end

  root to: 'visitors#index'
  devise_for :users

  resources :txts, only: [:index, :create]
  resources :bookings
end
