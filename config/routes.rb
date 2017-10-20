Rails.application.routes.draw do
  devise_for :users
  root 'documents#index'
  resources :documents
  resources :edits, only: [:show]
  # get '/edits/:id', to: 'edits#show', as: :edit_path
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
