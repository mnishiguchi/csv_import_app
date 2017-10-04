# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cities do
    collection do
      post :import
      delete :clear
    end
  end

  root "cities#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
