Rails.application.routes.draw do
  devise_for :users
  get 'contacts/index'

  resources :contacts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "contacts#index"

end
