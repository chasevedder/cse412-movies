Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  post '/averages' => 'application#averages'
  post '/count' => 'application#count_per_genre'
end
