Rails.application.routes.draw do

  root 'sessions#index'
  post 'sessions' => 'sessions#create'
  delete 'sessions/:id' => 'sessions#destroy'

  post 'users' => 'users#create'
  get 'dashboard/:id' => 'users#index'

  post 'items' => 'items#create'
  post 'purchases' => 'items#purchase'
  get 'shoes' => 'items#show'
  delete 'items/:id' => 'items#destroy'


end
