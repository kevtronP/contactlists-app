Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get "/contacts" => "contacts#index"
    get "/contacts/:id" => "contacts#show"
    post "/contacts/" => "contacts#create"
    patch "/contacts/:id" => "contacts#update"
    delete "/contacts/:id" => "contacts#destroy"

    post "/users" => "users#create"
  end
end