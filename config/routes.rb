Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

post '/details/new', to: 'check#new'
get '/details', to: 'check#index'
get '/details/:id', to: 'check#check'
put '/details/:id', to: 'check#update'
delete '/:id', to: 'check#delete' 
end
