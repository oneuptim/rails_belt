Rails.application.routes.draw do
  get '/' => 'users#index'

  post '/login' => 'users#login'

  get '/register' => 'users#register'

  post '/create_user' => 'users#create_user'

  get '/ideas' => 'users#ideas'

  get '/user/:id' => 'users#profile'

  post '/post_idea' => 'users#create_idea'

  get '/delete/:id' => 'users#delete_idea'

  post '/like_idea/:id' => 'users#like_idea'

  post '/unlike_idea/:id' => 'users#unlike_idea'

  post '/logout' => 'users#logout'

  # post '/thank/:id' => 'users#thank'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
